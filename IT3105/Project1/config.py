from configparser import ConfigParser

#Get the configparser object
config_object = ConfigParser()

#Assume we need 2 sections in the config file, let's call them USERINFO and SERVERCONFIG
config_object["BOARD"] = {
    "board_type": "d",  #can also be triangle(t)
    "board_size": 3,
    "open_holes": [(0,0),(0,1),(0,2)],
    "episodes": 100,

}

config_object["CRITIC"] = {
    "critic_method": "nn",  # Can also be Table Read(tr)
    "nn_dimensions": (15, 20, 30, 5, 1),
    "learning_rate": 0.01,
    "eligibility_decay_rate": 0.9,
    "discount_rate": 0.9
}


config_object["ACTOR"] = {
    "learning_rate": 0.1,
    "eligibility_decay_rate": 0.9,
    "discount_rate": 0.9
}

config_object["GENERAL"] = {
    "e_rate": 0.1,
    "frame_delay": 0.1,
    "e_greedy_decay_rate": 0.99
}

if __name__ == '__main__':
    with open('config.ini', 'w') as conf:
        config_object.write(conf)