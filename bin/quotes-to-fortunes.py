#! /usr/bin/env python3

"""Download all quotes from GoodReads by author's quote URL, print in fortune format.
Tested on Python 3.12, requires PyQuery 2.0.0+.
Assumes `python` points to `python3` - Install 'python-is-python3' on Debian(-based) distributions or specify 3 manually.
License: AGPL-3.0-only
Source: https://gist.github.com/C0rn3j/1bc48d933068da0fdba4089ac9f783ff
	Original: https://gist.github.com/JKirchartz/80ad6ec90d44b58486db89058d2fdb37
Donate:
	For Ko-Fi directly see https://ko-fi.com/martinrys
	See https://rys.rs/donate for other ways to help out
Usage:
	Output to file:
		python GoodreadsQuotes.py godin.txt 'https://www.goodreads.com/author/quotes/12130438.Dennis_E_Taylor'
	Output to file by using special name 'STDIN':
		python GoodreadsQuotes.py STDIN 'https://www.goodreads.com/author/quotes/12130438.Dennis_E_Taylor' > file.txt
	Output to terminal by using special name 'STDIN' - STDERR has logs, so you will see them on the terminal too:
		python GoodreadsQuotes.py STDIN 'https://www.goodreads.com/author/quotes/12130438.Dennis_E_Taylor'
	Output to terminal by using special name 'STDIN' - hiding STDERR:
		python GoodreadsQuotes.py STDIN 'https://www.goodreads.com/author/quotes/12130438.Dennis_E_Taylor' 2>/dev/null
"""

# Test single page: https://www.goodreads.com/author/quotes/14929130.TurtleMe
# Test multiple pages that aren't too long (7 atm): https://www.goodreads.com/author/quotes/12130438.Dennis_E_Taylor
# Test a very long 40+ pages author to make sure timeouts are enough: https://www.goodreads.com/author/quotes/1791.Seth_Godin

import logging
import re
import sys
import time
import requests

from pyquery import PyQuery

logging.basicConfig(
	level=logging.NOTSET,
	format='%(asctime)s [%(levelname)s] %(message)s',
	handlers=[
		logging.StreamHandler(),
	],
)

# Logging is set to INFO later by default

def grabber(*, url: str, partial_quotes: list[str] = [], seconds_between_requests: int = 2) -> tuple[list[str], bool]:
	try:
		page = PyQuery(url=url, headers={'user-agent': 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36'})
	# Not the best handling but at least retry once before giving up
	except (ConnectionResetError, TimeoutError, requests.exceptions.ReadTimeout):
		logging.exception(f'Failed downloading {url}, retrying in {seconds_between_requests*2}s!')
		time.sleep(seconds_between_requests*2)
		try:
			page = PyQuery(url=url, headers={'user-agent': 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36'})
		except (ConnectionResetError, TimeoutError, requests.exceptions.ReadTimeout):
			logging.critical(f'Failed downloading {url}, scrape failed, bailing out!')
			sys.exit(1)
		except Exception:
			logging.exception(f'Failed downloading {url}, scrape failed, Unknown Exception, bailing out!')
			sys.exit(1)
	except Exception:
		logging.exception(f'Failed downloading {url}, scrape failed, Unknown Exception, bailing out!')
		sys.exit(1)

#	logging.debug(f'Page content: {page}')

	quotes = page('.quoteText')
	logging.debug(f'Quotes found: "{quotes}"')

	for quote in quotes.items():
		logging.debug(f'Scraping quote "{quote}"')
		quote_text = str(quote.text())
		logging.debug(f'Scraped quote "{quote_text}"')
		logging.info(f'Found quote "{quote_text}"')
		partial_quotes.append(quote_text)

	next_page = page('.next_page')
	if next_page.text() == '':
		logging.warning(f'Could not find next_page secton for the following URL, ending further searching, this is expected if author only has very few quotes not enough to create multiple pages: {url}')
		return partial_quotes, False
	if not next_page.has_class('disabled'):
		return partial_quotes, True
	return partial_quotes, False

def page_loop(*, base_url: str, page_num: int = 1, seconds_between_requests: int = 2) -> list[str]:

	final_quotes = []
	should_continue = True
	while should_continue:
		if page_num > 1:
			logging.debug(f'Taking a short {seconds_between_requests}s timeout to not hammer the website')
			time.sleep(seconds_between_requests)
		url = f'{base_url}?page={page_num!s}'
		logging.info(f'Starting scrape for {base_url} on page number {page_num}')
		final_quotes, should_continue = grabber(url=url, partial_quotes=final_quotes, seconds_between_requests=seconds_between_requests)
		if should_continue:
			page_num=page_num + 1
	logging.info(f'We\'ve reached the end at page "{page_num}"!')
	return final_quotes

AUTHOR_REX = re.compile('\\d+\\.(\\w+)$')

if __name__ == '__main__':
	if len(sys.argv) != 3:
		print(__doc__)
		sys.exit(1)
	output_file = sys.argv[1]
#	if output_file == 'STDIN':
#		logging.getLogger().handlers[0].setLevel(logging.CRITICAL)
#	else:
#		logging.getLogger().handlers[0].setLevel(logging.INFO)
#	logging.getLogger().handlers[0].setLevel(logging.DEBUG)
	logging.getLogger().handlers[0].setLevel(logging.INFO)
	logging.debug('Starting script!')
	base_url = sys.argv[2]

	parsed_quotes = page_loop(base_url=base_url)

	# Output/write

	if output_file == 'STDIN':
		for quote in parsed_quotes:
			print(f'{quote}\n%')
	else:
		with open(output_file, 'w') as file:
			for quote in parsed_quotes:
				file.write(f'{quote}\n%\n')
	logging.debug('Script finished!')
