import math
import operator
def readfile():
	# train_triplet
	f1 = open("train_triplets.txt").readlines()
	# visible_triplet
	f2 = open("kaggle_visible_evaluation_triplets.txt").readlines()
	return f1,f2

def cal_song_count(f1,f2):
	# count songs in train_triplets
	song_count = dict()
	for line in f1:
		_,song,_ = line.strip("\n").split("\t")
		if song in song_count:
			song_count[song] +=1
		else:
			song_count[song] = 1
	# count songs in visible_triplets
	for line in f2:
		_,song,_ = line.strip("\n").split("\t")
		if song in song_count:
			song_count[song] +=1
		else:
			song_count[song] = 1
	return song_count


def cal_user_song_cnt(f1,f2):
	# song and cnt info from train_triplet for each user
	buser_song = dict(); buser_play = dict()
	for line in f1:
		user,song,cnt= line.strip("\n").split("\t")
		## user->song
		if user not in buser_song:
			buser_song[user] = [song]
		else:
			buser_song[user].append(song)	
		## user->plays	
		if user not in buser_play:
			buser_play[user] = int(cnt)
		else:
			buser_play[user] += int(cnt)

	# user and song info from visible triplet for each user
	user_song = dict()
	for line in f2:
		user,song,_= line.strip("\n").split("\t")
		# user->song
		if user not in user_song:
			user_song[user] = [song]
		else:
			user_song[user].append(song)
	return buser_song,buser_play,user_song

def song_idf(song_count,song_name):
	df = song_count[song_name]
	return math.log(1129318,df)

def recommand_song(user_id,buser_song,buser_play,user_song,song_count):
	# find similar users
        target = user_song[user_id]
	# similar[user v] -> similarity value
	similar = dict()
	for item in buser_song:
		base = buser_song[item]
		share = list(set(target)&set(base))
		if share == []:
			continue
		else:
			score = 0
			for ele in share:
				score += song_idf(song_count,ele)
			similar[item] = score
	max_score = max(similar.iteritems(), key=operator.itemgetter(1))[1]
	standard = 0.8*max_score
        similar_copy = similar.copy()
        for item in similar_copy:
		if similar_copy[item] < standard:
			similar.pop(item)


        # recommand songs according to similar users
        similar_artist = similar.keys()
        alternative_song = dict
        for sim in similar_artist:
            score = similar[sim]
            songs = buser_song.keys()
            for ele_song in songs:
                if ele_song not in alternative_song:
                    alternative_song[ele_song] = score/buser_play[sim]
                else:
                    alternative_song[ele_song] += score/buser_play[sim]
        alternative_songs = sorted(alternative_song.items(), key=operator.itemgetter(1))
        recommand_song = []
        for i in range(len(alternative_songs)-20,len(alternative_songs)-1):
            recommand_song.append(alternative_songs[i][0])
        return recommand_song



        

    
    
