from langchain_core.messages import AIMessage
import Authentication as aut
import Lezioni as lz
import streamlit as st

connection = aut.connetti_database()


def autenticazione(connection):
    st.session_state.username = None
    lz.reset_lesson()
    st.title('Autenticazione')

    st.sidebar.image("logo.svg", use_column_width=True)

    choice = st.sidebar.selectbox("Scegli", ["Login", "Registrati"])

    if choice == "Login":

        username = st.text_input("Username")
        password = st.text_input("Password", type="password")

        if st.button("Login"):
            if aut.verifica_credenziali(username, password, connection):
                st.success("Login effettuato")
                st.session_state.username = username
                st.session_state.pagina_corrente = 'Lezioni'
            else:
                st.error("Credenziali non valide")

    elif choice == "Registrati":

        email = st.text_input("Email")
        username = st.text_input("Username")
        api_key = st.text_input("OPENAI API-KEY", type="password")
        password = st.text_input("Password", type="password")

        if aut.validate_password(password) and aut.is_api_key_valid(api_key):
            confirm_password = st.text_input("Conferma Password")

            if st.button("Register") and aut.validated_password == confirm_password:
                aut.aggiungi_utente_al_database(username, password, email, api_key, connection)
                st.success("Utente registrato!")
            elif aut.validated_password != confirm_password:
                st.error("Le password inserite non coincidono")


def lezioni(connection):
    st.title('Lezioni')
    lz.setup_page()

    st.sidebar.image("logo.svg", use_column_width=True)
    if st.sidebar.button("Logout"):
        st.session_state.pagina_corrente = 'Autenticazione'

    lesson_selection = st.sidebar.selectbox("Seleziona Lezione",
                                            list(lz.get_prompt.get_lesson_guide(connection).keys()))

    cursor = connection.cursor()

    query = "SELECT API_key FROM Utenti WHERE Username = %s"
    values = (st.session_state.username,)

    cursor.execute(query, values)

    # Estrai i risultati
    api_key = cursor.fetchall()[0][0]

    lesson_info = lz.get_prompt.get_lesson_guide(connection)[lesson_selection]
    lesson_content = lz.load_lesson_content(lesson_info["file"])

    lesson_type = st.sidebar.radio("Come vuoi svolgere la lezione?",
                                   ["Lezione interattiva", "Lezione di ripasso con domande"])

    if st.session_state.get("current_lesson") != lesson_selection or st.session_state.get(
            "current_lesson_type") != lesson_type:
        st.session_state["current_lesson"] = lesson_selection
        st.session_state["current_lesson_type"] = lesson_type
        st.session_state["messages"] = [AIMessage(
            content="Benvenuto " + str(st.session_state.username) + "! Sono AiDe, il tuo assistente virtuale che ti "
                                                                    "guiderà nell'apprendimento"
                                                                    " dell'ingegneria del software. Scrivimi un messaggio non appena sei pronto per iniziare!"
        )]

    lz.display_lesson(lesson_selection, lesson_info)
    lz.handle_messages()

    if prompt := st.chat_input():
        st.chat_message("user").write(prompt)
        lz.run_langchain_model(prompt, lesson_type, lesson_content, lesson_selection, api_key)

    lz.download_chat()

    st.sidebar.button("Reimposta Lezione", on_click=lz.reset_lesson)
    container_checkbox = st.sidebar.container()
    container_button = st.empty()

    if lesson_type == "Lezione di ripasso con domande":
        if st.sidebar.checkbox('Mostra Progressi'):
            container_button.empty()
            container_centrale = lz.avanzamento_barra(connection)
        else:
            container_centrale = st.empty()


###################################################################

if 'pagina_corrente' not in st.session_state:
    st.session_state.pagina_corrente = 'Autenticazione'

# Mostra la pagina corrente
if st.session_state.get('pagina_corrente') == 'Autenticazione':
    autenticazione(connection)
elif st.session_state.get('pagina_corrente') == 'Lezioni':
    lezioni(connection)
