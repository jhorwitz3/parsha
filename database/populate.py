import firebase_admin
from firebase_admin import credentials, firestore
from datetime import datetime
import os
import json
import google.generativeai as genai
import datetime
from dateutil.relativedelta import relativedelta
import time


# constants
credPath = 'parsha-15dd3-firebase-adminsdk-o99zy-9c7a40f243.json'
gemPath = 'gemini-key.json'

def setupGemini():
    # Read API key
    with open(gemPath, 'r') as f:
        gemJson = json.load(f)
        gemKey = gemJson.get('key')
        genai.configure(api_key=gemKey)
        model = genai.GenerativeModel("gemini-1.5-flash")
        return model

def setupFirebaseClient():
    # Initialize the Firebase Admin SDK
    cred = credentials.Certificate(credPath)
    os.environ['GOOGLE_APPLICATION_CREDENTIALS'] = credPath
    print(f'cred: {cred}')
    firebase_admin.initialize_app(cred)

    db = firestore.Client()
    return db

def writeToSummaryDb(db, date, summary):
    # Add a document with the specified date and summary
    docRef = db.collection(u'summaries').document()
    docRef.set({
        u'date': date,
        u'summary': summary
    })

def getFridaysInYear(year):
  """Gets a list of datetime objects representing Fridays in a given year.

  Args:
    year: The year to check.

  Returns:
    A list of datetime objects.
  """

  start_date = datetime.datetime(year, 1, 1)
  end_date = datetime.datetime(year, 12, 31)

  fridays = []
  current_date = start_date
  while current_date <= end_date:
    if current_date.weekday() == 4:  # Thursday is 4 in Python's datetime module
      fridays.append(current_date)
    current_date += relativedelta(days=1)

  return fridays

def main():
    model = setupGemini()
    db = setupFirebaseClient()

    # Create a datetime object for the desired date and time
    # Example usage:
    year = 2025
    fridayDates = getFridaysInYear(year)
    count = 0
    for friday in fridayDates:
        print(friday.strftime("%Y-%m-%d"))
        prompt = f'can you provide a concise summary for the parsha on {friday.strftime("%Y-%m-%d") }and discuss the themes and ideas'

        response = model.generate_content(prompt)
        # print(response.text)
        writeToSummaryDb(db=db, date=friday, summary=response.text)

        # sleep for a minute every 15 requests because quota is 15 RPM
        count += 1
        if (count%15 == 0):
           time.sleep(60)

    print(f'Done writing summaries for {year}')


if __name__ == '__main__':
   main()   