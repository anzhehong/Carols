import math
import operator
import itertools
import random
import os

# get data from test dataset
def readfile():
	# train_triplet
	#f1 = open("train_triplets.txt").readlines()
	# visible_triplet
	#f2 = open("/home/saliency/Carols/MusicRecommendation/Kaggle/History.txt","r")
	f2 = open(("/Users/Harold_LIU/Desktop/myCode/Carols/BackEnd/SingingSong/src/main/webapp/WEB-INF/History.txt"),"r")
        return f2

def cal_usr_song_cnt(f2):
	user_song = dict()
        user_play = dict()
        song_count = dict()
	for line in f2:
            user,song,plays= line.strip("\n").split("\t")
            # user->song
            if user not in user_song:
                user_song[user] = [song]
            else:
                user_song[user].append(song)

            # user -> count    
            if user not in user_play:
                user_play[user] = int(plays)
            else:
                user_play[user] += int(plays)

            # song -> count
            if song in song_count:
                song_count[song] +=1
            else:
                song_count[song] = 1

        return user_song,user_play,song_count


# get data from train dataset
def get_history_user(cur):
	cur.execute("select distinct(user_id) from History;");cur.fetchall()
	users = list(itertools.chain.from_iterable(cur))
	return users


def get_all_songs(cur):
	cur.execute("select distinct(track_id) from History;");cur.fetchall()
	songs = list(itertools.chain.from_iterable(cur))
	return songs

def get_user_song(user_song,user_id):
	#cmd = "select track_id from History where user_id = '"+ user_id +"'"
	#cur.execute(cmd); cur.fetchall();
	#u_songs = list(itertools.chain.from_iterable(cur))
    return user_song[user_id]




def song_idf(song_count,track_id,num_users):
    df = song_count[track_id]
    return math.log(num_users,df)



def get_user_play(user_play,user_id):
	return user_play[user_id]

def recommend_song(user_song,user_play,song_count,trauser,target_songs,num_users):
	similar = dict()
	# find similar users
        randx =  random.sample(range(0,len(trauser)),len(trauser))
        for usr in trauser:
            base = get_user_song(user_song,usr)
            share = list(set(target_songs)&set(base))
            if share != []:
                score = 0
                for ele in share:
                    score += song_idf(song_count,ele,num_users)
                similar[usr] = score
	max_score = max(similar.iteritems(), key=operator.itemgetter(1))[1]
	standard = 0.8*max_score
        similar_copy = similar.copy()
        for item in similar_copy:
            if similar_copy[item] < standard:
                similar.pop(item)


        # recommand songs according to similar users
        similar_artist = similar.keys()
        alternative_song = dict()
        
        for sim in similar_artist:
            score  = similar[sim] ; back_songs  = get_user_song(user_song,sim)
            for ele_song in back_songs:
                    if ele_song not in alternative_song:
                            alternative_song[ele_song] = score/get_user_play(user_play,sim)
                    else:
                            alternative_song[ele_song] += score/get_user_play(user_play,sim)

        alternative_songs = sorted(alternative_song.items(), key=operator.itemgetter(1))
        re_song = []
        for i in range(len(alternative_songs)-20,len(alternative_songs)):
            re_song.append(alternative_songs[i][0])
        return re_song


def train_test_splitter():
#	conn = MySQLdb.connect(host='115.28.74.242',user='softwareReuse',
#		passwd='softwareReuse',db = "carols",port=3306)
#	cur = conn.cursor()
#	users = get_history_user(cur)
#	songs = get_all_songs(cur)
        f2 = readfile()
        user_song,user_play,song_count = cal_usr_song_cnt(f2)
        users = user_song.keys()
        songs = song_count.keys()
        num_users = len(users)
	test_user = random.sample(users,int(len(users)*0.01))
        
        # precision for evaluation
        AP = 0;test_idx = 1
        for test_uid in test_user:
            ix = users.index(test_uid)
            trauser = users[:ix]+users[ix+1:]
            all_songs =  get_user_song(user_song,test_uid)
            target_songs = all_songs[:int(len(all_songs)*0.5)]
            test_songs = all_songs[int(len(all_songs)*0.5):]
            # get the recommend results
            re_song = recommend_song(user_song,user_play,song_count,trauser,target_songs,num_users)
            #num = 0
            #for ele in re_song:
            #    if ele in test_songs:
            #        num = num +1
            #        print ele
            #AP += (num/20.0)
            hit = []
            part_AP=0
            for kk in range(len(re_song)):
                if re_song[kk] in test_songs:
                    hit.append(1)
                    print re_song[kk]
                else:
                    hit.append(0)
            hit_num = []
            for j in range(len(hit)):
                hit_num.append(sum(hit[:j+1]))
            for j in range(len(hit)):
                part_AP += hit[j]*hit_num[j]
            AP =part_AP/(20*1.0)+AP
            test_idx += 1
            print AP/test_idx,test_uid, re_song
        AP = AP/len(test_user)
        return AP

#train_test_splitter()

def read_in_memory(test_uid):
    f2 = readfile()
    user_song,user_play,song_count = cal_usr_song_cnt(f2)
    users = user_song.keys()
    songs = song_count.keys()
    num_users = len(users)
    ix = users.index(test_uid)
    trauser = users[:ix]+users[ix+1:]
    all_songs =  get_user_song(user_song,test_uid)
    target_songs = all_songs[:int(len(all_songs)*0.5)]
    test_songs = all_songs[int(len(all_songs)*0.5):]
    # get the recommend results
    re_song = recommend_song(user_song,user_play,song_count,trauser,target_songs,num_users)
    return re_song
