# -*- coding: utf-8 -*-
"""
Created on Thu Apr 30 15:37:47 2020

@author: bosse
"""

import win32com.client as win32
outlook = win32.Dispatch('outlook.application')
mail = outlook.CreateItem(0)
mail.To = 'jul.bosse.06@gmail.com'
mail.Subject = 'Message subject'
mail.Body = 'Message body'
mail.HTMLBody = '<h2>HTML Message body</h2>' #this field is optional

# To attach a file to the email (optional):
attachment  = "Path to the attachment"
# mail.Attachments.Add(attachment)

mail.Send()