import time

from selenium import webdriver
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.chrome.service import Service
import os
import json
import urllib
import urllib.request
import sys
import time
import numpy as np

service = Service(executable_path="/home/simplon/GitHub_Simplon/Dev_IA_Simplon/Dev_IA_Simplon/projets_ML/Pokédex/chromedriver")

service.start()

# Configuration
download_path = "/home/simplon/Documents/dataset_pokedex/"
# Images
pokemon_list = json.load("pokemons.json")
words_to_search = ['bulbasaur','charmander','squirtle']
suffixes=["png","sprite","anime"]
n = 50
nb_to_download = list(map(int,np.ones(len(words_to_search))*n))

def main():
    if len(words_to_search) != len(nb_to_download) :
        raise ValueError('You may have forgotten to configure one of the lists (length is different)')
    i= 0
    # For each word in the list, we download the number of images requested
    while i<len(words_to_search):
        print("Words "+str(i)+" : "+str(nb_to_download[i])+"x\""+words_to_search[i]+"\"")
        if nb_to_download[i] > 0:
            search_and_save(words_to_search[i],nb_to_download[i])
        i+=1
    
def search_and_save(text,number):
    # Create directories to save images
    if not os.path.exists(download_path + text.replace(" ", "_")):
        os.makedirs(download_path + text.replace(" ", "_"))

    img_count = 0
    for suffixe in suffixes:
        downloaded_img_count = 0
        print("SUFFIXE:",suffixe)
        url="https://www.google.co.in/search?q="+text+" "+suffixe+"&source=lnms&tbm=isch"
        driver = webdriver.Remote(service.service_url)
        driver.maximize_window()
        driver.get(url)
        headers = {}
        headers['User-Agent'] = "Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2228.0 Safari/537.36"
    
        time.sleep(0)

        extensions = {"jpg", "jpeg", "png", "gif"}

        imges = driver.find_elements_by_class_name('rg_i')

        for img in imges:
            img_count += 1
            img_url = img.get_attribute("src")
            print("Downloading image "+ str(img_count) + ": "+ img_url[:20])
            try:
                # Download image and save it
                req = urllib.request.Request(img_url, headers=headers)
                raw_img = urllib.request.urlopen(req).read()
                f = open(download_path+text.replace(" ", "_")+"/"+str(img_count), "wb")
                f.write(raw_img)
                f.close
                downloaded_img_count += 1
            except Exception as e:
                print("Download failed:"+ str(e))
            finally:
                print("")
            if downloaded_img_count >= number:
                break

        driver.close()

if __name__ == "__main__":
    main()