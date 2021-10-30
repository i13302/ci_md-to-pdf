# https://github.com/maxvst/python-selenium-chrome-html-to-pdf-converter/blob/master/sample/html_to_pdf_converter.py
import sys
from selenium import webdriver
from selenium.webdriver.chrome.options import Options
import json
import base64


def send_devtools(driver, cmd, params={}):
	resource = "/session/%s/chromium/send_command_and_get_result" % driver.session_id
	url = driver.command_executor._url + resource
	body = json.dumps({'cmd': cmd, 'params': params})
	response = driver.command_executor._request('POST', url, body)
	if response.get('status'):
		raise Exception(response.get('value'))
	return response.get('value')


def get_pdf_from_html(path, chromedriver='./chromedriver', print_options={}):
	webdriver_options = Options()
	webdriver_options.binary_location = '/usr/bin/google-chrome-beta'
	webdriver_options.add_argument('--headless')
	webdriver_options.add_argument('--disable-gpu')
	webdriver_options.add_argument('--no-sandbox')
	webdriver_options.add_argument("--lang=ja")
	driver = webdriver.Chrome(chromedriver, options=webdriver_options)

	driver.get(path)

	calculated_print_options = {
            'marginTop': 0.6,
            'landscape': False,
            'displayHeaderFooter': True,
            'printBackground': True,
            'preferCSSPageSize': True,
            'headerTemplate': '<div style="font-size: 9px; margin-left: 1cm;"> <span class="title"></span></div> <div style="font-size: 9px; margin-left: auto; margin-right: 1cm; "> <span class="date"></span></div>',
            'footerTemplate': '<div style="font-size: 9px; margin: 0 auto;"> <span class="pageNumber"></span> / <span class="totalPages"></span></div>',
            'format_option': 'A4'
	}
	calculated_print_options.update(print_options)
	result = send_devtools(driver, "Page.printToPDF", calculated_print_options)
	driver.quit()
	return base64.b64decode(result['data'])


def write_file_from_base64(base64, pdfpath):
	with open(pdfpath, 'wb') as f:
		f.write(base64)


if __name__ == "__main__":
	write_file_from_base64(
            get_pdf_from_html('file:///data/'+sys.argv[1], '/usr/local/bin/chromedriver'), '/data/'+sys.argv[2])
	# pass
	# TODO: add short help layout
