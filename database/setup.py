import firebase_admin
from firebase_admin import credentials, firestore
from datetime import datetime
import os

cred_path = 'parsha-15dd3-firebase-adminsdk-o99zy-9c7a40f243.json'

# Initialize the Firebase Admin SDK
cred = credentials.Certificate(cred_path)
os.environ['GOOGLE_APPLICATION_CREDENTIALS'] = cred_path
print(f'cred: {cred}')
firebase_admin.initialize_app(cred)

db = firestore.Client()

# Create a datetime object for the desired date and time
specific_date = datetime(2024, 12, 27, 15, 0)  # Year, Month, Day, Hour, Minute

# Add a document with the specified date and summary
doc_ref = db.collection(u'summaries').document()
doc_ref.set({
    u'date': specific_date,
    u'summary': u'summary here'
})