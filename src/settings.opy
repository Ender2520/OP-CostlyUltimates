#!mainFile "main.opy"

settings {
    "main": {
        "description": "All the ultimates are very OP but they are expensive. This is kind of a testing ground for my planned gamemode ReWatch, so please provide feedback in my discord.",
        "modeName": "Overwatch OP & Costly Ultimates"
    },
    "lobby": {
        "team1Slots": 5,
        "team2Slots": 5
    },
    "gamemodes": {
        "assault": {},
        "control": {},
        "escort": {},
        "hybrid": {},
        "general": {
            "gamemodeStartTrigger": "manual",
            "roleLimit": "2OfEachRolePerTeam"
        }
    },
    "heroes": {
        "allTeams": {
            "ana": {
                "ultGen%": 90
            },
            "ashe": {
                "enableInfiniteUlt": true,
                "ultGen%": 70
            },
            "baptiste": {
                "ultGen%": 70
            },
            "bastion": {
                "ultGen%": 65,
                "ultDuration%": 50
            },
            "brigitte": {
                "ultGen%": 80
            },
            "dva": {
                "ultGen%": 75
            },
            "doomfist": {
                "ultGen%": 70
            },
            "echo": {
                "ultGen%": 50
            },
            "genji": {
                "ultGen%": 65
            },
            "hanzo": {
                "ultGen%": 50
            },
            "junkrat": {
                "ultGen%": 75
            },
            "lucio": {
                "ultGen%": 70
            },
            "mccree": {
                "ultGen%": 70
            },
            "mei": {
                "ultGen%": 80
            },
            "mercy": {
                "ultGen%": 70
            },
            "moira": {
                "ultGen%": 75
            },
            "orisa": {
                "ultGen%": 70
            },
            "pharah": {
                "ultGen%": 80
            },
            "reaper": {
                "ultGen%": 80
            },
            "reinhardt": {
                "ultGen%": 85
            },
            "roadhog": {
                "ultGen%": 75
            },
            "sigma": {
                "ultGen%": 85
            },
            "soldier": {
                "ultGen%": 70
            },
            "sombra": {
                "ultGen%": 70
            },
            "symmetra": {
                "ultGen%": 90
            },
            "torbjorn": {
                "ultGen%": 70,
                "ultDuration%": 25
            },
            "tracer": {
                "ultGen%": 75
            },
            "widowmaker": {
                "ultGen%": 50
            },
            "winston": {
                "ultGen%": 75
            },
            "hammond": {
                "ultGen%": 75
            },
            "zarya": {
                "ultGen%": 70
            },
            "zenyatta": {
                "ultGen%": 80
            },
            "enabledHeroes": [
                "ana",
                "ashe",
                "baptiste",
                "bastion",
                "brigitte",
                "dva",
                "doomfist",
                "echo",
                "genji",
                "hanzo",
                "junkrat",
                "lucio",
                "mccree",
                "mei",
                "mercy",
                "moira",
                "orisa",
                "pharah",
                "reaper",
                "reinhardt",
                "roadhog",
                "sigma",
                "soldier",
                "sombra",
                "symmetra",
                "torbjorn",
                "tracer",
                "widowmaker",
                "winston",
                "hammond",
                "zarya",
                "zenyatta",
            ]
        }
    }
}