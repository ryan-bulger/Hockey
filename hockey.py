import streamlit as st
import requests
import pandas as pd
from datetime import datetime, timedelta

def _teams():
    response = requests.get('https://statsapi.web.nhl.com/api/v1/teams').json()
    teams = [
                {
                    'teamName':response['teams'][i]['teamName'], 
                    'division': response['teams'][i]['division']['name'],
                    'conference': response['teams'][i]['conference']['name'],
                    'rosterLink': response['teams'][i]['link'],
                } 
            for i in range(32)
            ]
    return teams

def _roster(teams):
    teams
    txt = [teams[i]['rosterLink'] for i in range(32)][20]
    txt
    response = requests.get('https://statsapi.web.nhl.com'+txt+'/roster').json()
    players = [
                {
                    'name': response['roster'][i]['person']['fullName'],
                    'jerseyNumber': response['roster'][i]['jerseyNumber'],
                    'position' : response['roster'][i]['position']['abbreviation'],
                    'playerLink': response['roster'][i]['person']['link'],
                }
            for i in range(len(response['roster']))
            ]
    players

# teams = _teams()

# _roster(teams)

j = requests.get(f'https://statsapi.web.nhl.com/api/v1/people/8476454/stats?stats=gameLog&season=20222023').json()
df = pd.json_normalize(j['stats'][0]['splits'])
df.iloc[:10,]
