import streamlit as st
import streamlit_authenticator as sta

# Inizializza la variabile login_manager
sta.login_manager.init_app(st)

# Funzione per controllare la validità della password
def check_password_strength(password):
    # Controllo lunghezza minima
    if len(password) < 8:
        return False, "La password deve contenere almeno 8 caratteri"

    # Controllo almeno un carattere maiuscolo
    if not any(char.isupper() for char in password):
        return False, "La password deve contenere almeno un carattere maiuscolo"

    # Controllo almeno un numero
    if not any(char.isdigit() for char in password):
        return False, "La password deve contenere almeno un numero"

    # Controllo almeno un carattere speciale
    if not re.search(r"[!@#$%^&*(),.?\":{}|<>]", password):
        return False, "La password deve contenere almeno un carattere speciale"

    return True, "Password valida"

# Funzione per effettuare il login
def login():
    # Controllo se l'utente è già autenticato
    if sta.login_manager.is_logged_in():
        st.warning("L'utente è già autenticato.")
        return

    # Creazione dei campi di input
    email = st.text_input("Email")
    password = st.text_input("Password", type="password")

    # Autenticazione dell'utente
    if st.button("Accedi"):
        if sta.login_manager.authenticate(email, password):
            st.success("Accesso effettuato con successo!")
        else:
            st.error("Accesso non riuscito: dati non validi")


# Funzione per registrare un nuovo utente
def register():
    # Controllo se l'utente è già autenticato
    if sta.login_manager.is_logged_in():
        st.warning("L'utente è già autenticato.")
        return

    # Creazione dei campi di input
    nome = st.text_input("Nome")
    cognome = st.text_input("Cognome")
    email = st.text_input("Email")
    password = st.text_input("Password", type="password")
    confirm_password = st.text_input("Conferma password", type="password")

    # Controllo della validità della password
    is_valid, message = check_password_strength(password)

    # Visualizzazione del feedback sulla validità della password
    if not is_valid:
        st.error(message)
    else:
        password_feedback_placeholder = st.empty()

    # Controllo della conferma della password
    if password and confirm_password:
        if password == confirm_password:
            confirm_password_feedback_placeholder = st.empty()
        else:
            confirm_password_feedback_placeholder = st.error("Le password non corrispondono")

    # Registrazione dell'utente
    if st.button("Registrati"):
        if register_user(nome, cognome, email, password):
            st.success("Registrazione avvenuta con successo!")
        else:
            st.error("Errore durante la registrazione: dati non validi")


# Pagina principale
st.title("Login o Registrazione")

# Visualizzazione del menu di scelta
if sta.login_manager.is_logged_in():
    st.write("Benvenuto, [nome utente]")
else:
    menu = st.selectbox("Cosa vuoi fare?", ["Login", "Registrazione"])

# Esecuzione della funzione scelta dall'utente
if menu == "Login":
    login()
elif menu == "Registrazione":
    register()
