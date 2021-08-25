import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
import datetime
from matplotlib.animation import FuncAnimation

data = pd.read_csv("donnees/caracteristiques-2019.csv",sep=";")

data["long"]=data["long"].apply(lambda x: float(x.replace(',','.')))
data["lat"]=data["lat"].apply(lambda x: float(x.replace(',','.')))

data["date"]=data["jour"].apply(str)+"/"+data["mois"].apply(str)+"/"+data["an"].apply(str)
data["doy"]= data["date"].apply(lambda x: datetime.datetime.strptime(x,'%d/%m/%Y').timetuple().tm_yday)

fig, ax = plt.subplots(1,1,figsize=(9,9))

img=plt.imread("donnees/france.png")

def animate(i):
    print(i)
    ax.clear()
    ax.imshow(img,extent=[-6.5,10,41,52])
    ax.scatter(data["long"][data["doy"]==i],data['lat'][data["doy"]==i], marker='o', color='red', s=2);
    ax.set_xlabel(str(i))
    ax.set_xlim([-6,10])
    ax.set_ylim([41,52])

ani = FuncAnimation(fig, animate, frames=365, interval=50, repeat=False)

plt.show()