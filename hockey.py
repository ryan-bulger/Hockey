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
df = df.iloc[:13,]

toi_cols = ['stat.timeOnIce','stat.powerPlayTimeOnIce','stat.evenTimeOnIce','stat.shortHandedTimeOnIce']
df[toi_cols] = df[toi_cols].apply(lambda x: pd.to_timedelta('00:' + x).dt.total_seconds())
df
df2 = df.groupby('season').agg(
    GP=pd.NamedAgg(column='stat.games',aggfunc='sum'),
    G=pd.NamedAgg(column='stat.goals',aggfunc='sum'),
    A=pd.NamedAgg(column='stat.assists',aggfunc='sum'),
    Pts=pd.NamedAgg(column='stat.points',aggfunc='sum'),
    PlusMinus=pd.NamedAgg(column='stat.assists',aggfunc='sum'),
    Sh=pd.NamedAgg(column='stat.shots',aggfunc='sum'),
    ShPct=pd.NamedAgg(column='stat.shotPct',aggfunc='mean'),
    SHG=pd.NamedAgg(column='stat.shortHandedGoals',aggfunc='sum'),
    SHPts=pd.NamedAgg(column='stat.shortHandedPoints',aggfunc='sum'),
    PPG=pd.NamedAgg(column='stat.powerPlayGoals',aggfunc='sum'),
    PPPts=pd.NamedAgg(column='stat.powerPlayPoints',aggfunc='sum'),
    GWG=pd.NamedAgg(column='stat.gameWinningGoals',aggfunc='sum'),
    PIMs=pd.NamedAgg(column='stat.pim',aggfunc='sum'),
    H=pd.NamedAgg(column='stat.hits',aggfunc='sum'),
    Blk=pd.NamedAgg(column='stat.blocked',aggfunc='sum'),
    TOI=pd.NamedAgg(column='stat.timeOnIce',aggfunc='mean'),
    PPTOI=pd.NamedAgg(column='stat.powerPlayTimeOnIce',aggfunc='mean'),
    SHTOI=pd.NamedAgg(column='stat.shortHandedTimeOnIce',aggfunc='mean'),
    
    

                        )
df2