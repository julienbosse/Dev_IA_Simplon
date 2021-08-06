# -*- coding: utf-8 -*-
"""
Created on Tue Mar 24 14:14:55 2020

@author: bosse
"""
import win32com.client as win32
from selenium import webdriver
from time import sleep
import os
import glob
import datetime as dt
# from datetime import datetime


# =============================================================================
#  BOT ATTESTATION
# =============================================================================

Mams = ['Isabelle','Bosse','19/03/1957','Garches','499 Avenue Janvier Passero','Mandelieu','06210','isabosse@orange.fr']
Paps = ['Philippe','Bosse','10/10/1957','Dakar','499 Avenue Janvier Passero','Mandelieu','06210','philippe@bosse.pro']
Ju = ['Julien','Bosse','18/06/1996','Melun','499 Avenue Janvier Passero','Mandelieu','06210','jul.bosse.06@gmail.com']
Mat = ['Mathieu','Bosse','18/06/1996','Melun','499 Avenue Janvier Passero','Mandelieu','06210','mathieu.bosse@gmail.com']

# =============================================================================
# BIT ATTESTATION
# =============================================================================

PERSONNE = Mat
MOTIF = 'courses'
DECALAGE = 30

class AttestationBot:
    def __init__(self,personne,motif,decal):
        
        self.driver = webdriver.Chrome('E:\PROGRAMMATION\Python Chrome\chromedriver.exe')
        self.driver.get('https://media.interieur.gouv.fr/deplacement-covid-19/')
        
        self.driver.find_element_by_name('firstname').send_keys(personne[0])
        self.driver.find_element_by_name('lastname').send_keys(personne[1])
        self.driver.find_element_by_name('birthday').send_keys(personne[2])
        self.driver.find_element_by_name('lieunaissance').send_keys(personne[3])
        self.driver.find_element_by_name('address').send_keys(personne[4])
        self.driver.find_element_by_name('town').send_keys(personne[5])
        self.driver.find_element_by_name('zipcode').send_keys(personne[6])
        
        now = dt.datetime.now()
        now5 = now + dt.timedelta(0, 0, 0, 0, decal, 0, 0)
        global current_time 
        current_time  = str(now5.hour)+':'+str(now5.minute)
        
        self.driver.find_element_by_name('heure').send_keys(current_time)
        
        if motif=='sport' :
            self.driver.find_element_by_xpath('//*[@id="checkbox-sport"]').click() 
        elif motif=='courses' :
            self.driver.find_element_by_xpath('//*[@id="checkbox-courses"]').click() 
            
        self.driver.find_element_by_xpath('//*[@id="generate-btn"]').click()
        
class MailBot:
    def __init__(self,personne):
                # =============================================================================
        #  CHEMIN ATTESTATION
        # =============================================================================
        
        path = 'c:/Users/bosse/Downloads/*'
        list_of_files = glob.glob(path) # * means all if need specific format then *.csv
        latest_file = max(list_of_files, key=os.path.getctime)
        
        # =============================================================================
        # MAIL
        # =============================================================================
        
        outlook = win32.Dispatch('outlook.application')
        mail = outlook.CreateItem(0)
        mail.To = personne[7]
        mail.Subject = 'Attestation '+current_time 
        
        attachment  = latest_file
        mail.Attachments.Add(attachment)
        
        mail.Send()




my_bot = AttestationBot(PERSONNE,MOTIF,DECALAGE)

sleep(1)

my_bot = MailBot(PERSONNE)

print('FINI')

