import os

def generate_pokemon_file(pokemon):
    with open("/home/simplon/Documents/dataset_pokedex/"+pokemon+".txt",'w') as f:
        for filename in os.listdir("/home/simplon/Documents/dataset_pokedex/"+pokemon):
            print("/home/simplon/Documents/dataset_pokedex/"+pokemon+'/'+filename+'\n')
            f.write("/home/simplon/Documents/dataset_pokedex/"+pokemon+'/'+filename+'\n')

generate_pokemon_file("bulbasaur")
generate_pokemon_file("charmander")
generate_pokemon_file("squirtle")