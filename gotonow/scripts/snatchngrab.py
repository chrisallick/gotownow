import json
import urllib2
import urllib
import urlparse
import uuid
import shutil
import os

data = urllib2.urlopen('http://snatchandstync.herokuapp.com/')

j = json.load(data)
if j["nzb"]:
	nzb = json.loads( j["nzb"] )
	parsed = urlparse.urlparse(nzb["url"])
	url = "http://api.nzbmatrix.com/v1.1/download.php?id=%s&username=%s&apikey=%s" % ( urlparse.parse_qs(parsed.query)['id'][0], "35dodworth", "81193ffd00882a0a4556d2b27ae81006")
	try:
		urllib.urlopen(url)
		print "downloading... %s" % url
		response = urllib2.urlopen(url)
		fname = "/home/chrisallick/.sabnzbd/nzbs/"+str(uuid.uuid1())+".nzb"
		f = open( fname, "w")
		f.write( response.read() )
		f.close()

	except IOError:
		print "Not a real URL"