import csv
import os
import time

import bs4
from selenium import webdriver
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.common.action_chains import ActionChains
from selenium.webdriver.common.by import By
from webdriver_manager.chrome import ChromeDriverManager

MAIN_URL = 'https://www.investing.com/economic-calendar/'
# BULL IDENTIFIER 
FULL_BULL_IDENT = 'grayFullBullishIcon'

# declare the data dir and create it if not exists
BASEDIR = 'Data'
os.makedirs(BASEDIR, exist_ok=True)

# COL INDEXES
TIME_IDX = 0
CURR_IDX = 1
IMPT_IDX = 2
EVENT_IDX = 3
ACTUAL_IDX = 4
FORECAST_IDX = 5
PREVIOUS_IDX = 6


def get_number_of_bull(td_data):
    return len(td_data.find_all('i', class_=FULL_BULL_IDENT))


def get_row_data(tr_soup):
    tds = tr_soup.find_all('td')
    ann_time = '00:30' if tds[TIME_IDX].text.replace('\xa0', '').strip() == 'Tentative' else tds[TIME_IDX].text.replace(
        '\xa0', '').strip()
    note = tds[TIME_IDX].text.replace('\xa0', '').strip() if tds[TIME_IDX].text.replace('\xa0',
                                                                                        '').strip() == 'Tentative' else None
    curr_name = tds[CURR_IDX].text.replace('\xa0', '').strip()
    bulls = get_number_of_bull(tds[IMPT_IDX])
    event_name = tds[EVENT_IDX].text.replace('\xa0', '').strip()

    actual = tds[ACTUAL_IDX].text.strip()
    forecast = tds[FORECAST_IDX].text.replace('\xa0', '').strip()
    previous = tds[PREVIOUS_IDX].text.replace('\xa0', '').strip()
    date_ = tr_soup.get('data-event-datetime', '').split()[0]
    return {'date': date_, 'currency': curr_name, 'time': ann_time, 'note': note, 'bulls': bulls,
            'event_text': event_name,
            'actual': actual, 'forecast': forecast, 'previous': previous}


def convert_value(value):
    if value.endswith('K'):
        return float(value.replace('K', '').strip()) * 1000
    elif value.endswith('M'):
        return float(value.replace('M', '').strip()) * 1000000
    elif value.endswith('B'):
        return float(value.replace('B', '').strip()) * 1000000000
    elif value.endswith('T'):
        return float(value.replace('T', '').strip()) * 1000000000000
    elif value.endswith('%'):
        return float(value.replace('%', '').strip()) / 100
    else:
        return value


def get_actual_forecast_previous_logic(actual, fore_prev):
    try:
        if actual is not None and fore_prev is not None:
            return (actual - fore_prev) / abs(fore_prev)
    except ZeroDivisionError:
        return None
    return None


def closeBtn(c):
    try:
        c.find_element_by_id('closeBtn').click()
    except Exception as ex:
        print(ex)
        delete_overlay(c)


def login(c, username, password):
    # we should login
    # initiate the login buton
    c.execute_script('overlay.overlayLogin();')
    # enter the email
    c.find_element_by_name('loginFormUser_email').send_keys(username)
    # enter the password
    c.find_element_by_id('loginForm_password').send_keys(password)
    # click the login button
    c.execute_script('loginFunctions.submitLogin();')


def delete_overlay(c):
    try:
        c.execute_script("document.getElementById('PromoteSignUpPopUp').remove()")
        c.execute_script("document.getElementsByClassName('generalOverlay')[0].remove()")
    except Exception:
        pass


def start():
    try:
        username = 'v_koul@hotmail.com'
        password = 'dekH56cHand'
        # start the browser
        options = Options()
        options.headless = True
        # Windows
        c = webdriver.Chrome('chromedriver.exe', options=options)

        # MAC OS
        # s = Service(ChromeDriverManager().install())
        # c = webdriver.Chrome(service=s, options=options)

        # visit the page
        c.get(MAIN_URL)
        time.sleep(20)

        # login to the site
        login(c, username, password)
        # wait for
        # c.get_element_by_id('userAccount')
        time.sleep(10)

        # click on the 'this week'
        e = c.find_element(By.ID, 'timeFrame_thisWeek')
        actions = ActionChains(c)
        actions.move_to_element(e).perform()
        e.click()

        # wait for it to process, here's a static wait time
        time.sleep(10)

        # click on the 'Calendar'
        e = c.find_element(By.ID, 'datePickerToggleBtn')
        actions = ActionChains(c)
        actions.move_to_element(e).perform()
        e.click()

        e = c.find_element(By.ID, 'startDate')
        start_date = e.get_attribute('value')
        year = int(start_date.split('/')[2])
        e.clear()
        e.send_keys(start_date.replace(str(year), str(year - 2)))

        # click on the 'Apply Button'
        e = c.find_element(By.ID, 'applyBtn')
        actions = ActionChains(c)
        actions.move_to_element(e).perform()
        e.click()
        # wait for it to process, here's a static wait time
        time.sleep(10)

        # Get scroll height.
        last_height = c.execute_script("return document.body.scrollHeight")
        print(f'Initial Height: {last_height}')
        while True:
            # Scroll down to the bottom.
            c.execute_script("window.scrollTo(0, document.body.scrollHeight);")
            # Wait to load the page.
            time.sleep(20)
            # Calculate new scroll height and compare with last scroll height.
            new_height = c.execute_script("return document.body.scrollHeight")
            print(f'New Height: {new_height}')

            if new_height == last_height:
                break

            last_height = new_height

        # process the data
        soup = bs4.BeautifulSoup(c.page_source, 'html.parser')
        tbl = soup.find('table', id='economicCalendarData')
        trs = tbl.find_all('tr', class_='js-event-item')
        header = ['date', 'time', 'Cur', 'Imp', 'Event', 'Actual', 'forecast', 'previous']
        output_file = os.path.join(BASEDIR, 'investing_output.csv')
        print(f'Writing output to {output_file}')
        with open(output_file, 'w', newline='') as fp:
            writer = csv.writer(fp)
            writer.writerow(header)
            for tr in trs:
                obj = get_row_data(tr)
                print(obj)
                writer.writerow([obj['date'],
                                 obj['time'],
                                 obj['currency'],
                                 obj['bulls'],
                                 obj['event_text'],
                                 obj['actual'],
                                 obj['forecast'],
                                 obj['previous']
                                 ])
        print('DONE!')
    finally:
        c.quit()


if __name__ == '__main__':
    start()
