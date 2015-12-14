#!/usr/bin/python

import sys
import nmap
import threading

class myThread (threading.Thread):
	def __init__(self, ip, func, allowed_ports):
		threading.Thread.__init__(self)
		self.ip = ip
		self.func = func
	
	def run(self):
		scan = self.func(ip)
		self.check(scan)

	def check(scan):
		assert scan['nmap']['scanstats']['uphosts'] == '1'
		for tcp in scan['scan'][self.ip]['tcp'].keys():
			assert tcp in allowed_ports

if __name__ == '__main__':
	listOfAgentIPAdresses = {}
	allowed_ports = [22,25,80,111]

	for each_agent in sys.argv[1]:
		listOfAgentIPAdresses.append({each_agent['data']['name']:each_agent['data']['parameters']['ipaddress']})

	scanner = nmap.PortScanner()
	for each_agent in listOfAgentIPAdresses:
		thread = myThread(listOfAgentIPAdresses[each_agent], scanner, allowed_ports)
		thread.start()