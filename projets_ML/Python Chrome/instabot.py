# -*- coding: utf-8 -*-
"""
Created on Tue Mar 24 14:14:55 2020

@author: bosse
"""

from selenium import webdriver
from time import sleep

class InstagramBot:
    def __init__(self,username,password):
        self.driver = webdriver.Chrome('E:\PROGRAMMATION\Python Chrome\chromedriver.exe')
        self.username = username
        self.driver.get('https://instagram.com')
        
        sleep(2)
        
        self.driver.find_element_by_name('username').send_keys(username)
        self.driver.find_element_by_name('password').send_keys(password)
        self.driver.find_element_by_xpath("/html/body/div[1]/section/main/article/div[2]/div[1]/div/form/div[4]/button/div").click()
        sleep(3)
        self.driver.find_element_by_xpath("/html/body/div[4]/div/div/div[3]/button[2]").click()
        sleep(2)
        
    def get_unfollowers(self):
        self.driver.find_element_by_xpath("//a[contains(@href,'/{}')]".format(self.username)).click()
        sleep(2)
        self.driver.find_element_by_xpath("//a[contains(@href,'/following')]")

my_bot = InstagramBot('juliobosse','*********')
my_bot.get_unfollowers()