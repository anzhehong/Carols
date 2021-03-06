//
//  ViewController.swift
//  LXDMusicPlayer
//
//  Created by  Harold LIU on 5/5/16.
//  Copyright © 2016 Tongji Apple Club. All rights reserved.
//

import UIKit
import SDWebImage
import MediaPlayer
import Alamofire
import CustomIOSAlertView
import PKHUD


enum PlayMode {
    case SingleSong
    case Loop
    case Shuffle
}

let kStatusKVOKey = UnsafeMutablePointer<(Void)>()
let kDurationKVOKey = UnsafeMutablePointer<(Void)>()
let kBufferingRatioKVOKey = UnsafeMutablePointer<()>()

class PlayViewController: UIViewController,CustomIOSAlertViewDelegate{
    
    //MARK:- Let PlayView be Signton
    static var sharedInstance :PlayViewController {
        struct Static {
            static var onceToken: dispatch_once_t = 0
            static var instance: PlayViewController? = nil
        }
        dispatch_once(&Static.onceToken) {
            Static.instance = nil
            Static.instance = (UIStoryboard(name: "PlayView", bundle: nil).instantiateViewControllerWithIdentifier("musicVC")) as? PlayViewController
        }
        return Static.instance!
    }
    
    @IBOutlet weak var Background: UIView!
    @IBOutlet weak var BackgroundImage: UIImageView!
    @IBOutlet weak var menu: UIButton!
    @IBOutlet weak var SongsImage: UIImageView!
    @IBOutlet weak var HeartLike: UIButton!
    @IBOutlet weak var StartTime: UILabel!
    @IBOutlet weak var EndTime: UILabel!
    @IBOutlet weak var MusicTimeSlider: MusicSlider!
    @IBOutlet weak var ModelButton: UIButton!
    @IBOutlet weak var PlayButton: UIButton!
    @IBOutlet weak var ScoreBackgroundView: EZAudioPlotGL!
    @IBOutlet weak var StandardView: EZAudioPlotGL!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var singerLabel: UILabel!
    @IBOutlet weak var originalLabel: UILabel!
    @IBOutlet weak var SongTitle: UILabel!
    
    //MARK:- Params
    var dontReloadMusic:Bool = false
    var songs = NSMutableArray()
    var currentSong:Song?
    var songTitl:String? {
        didSet {
            SongTitle.text = songTitl
        }
    }
    var specialIndex:Int?
    var parentId:NSNumber?
    var isNotPresenting:Bool?
    var scoreModel:Bool = false
    var lyric: String?
    var visualEffictView = UIVisualEffectView()
    let musicIndicator = MusicIndicator.sharedInstance
    var lastMusicURL = ""
    var randomArray = NSMutableArray()
    var originArray = NSMutableArray()
    var musicDurationTimer:NSTimer?
    var currentIndex:Int = 0
    var isReplay:Bool = false
    var like:Bool = false {
        didSet {
            if like {
                HeartLike.setImage(UIImage(named:"red_heart"), forState: .Normal)
            }
            else {
                HeartLike.setImage(UIImage(named:"empty_heart"), forState: .Normal)
            }
        }
    }
    var playMode = PlayMode.Loop {
        didSet {
            switch playMode {
            case .Loop:
                ModelButton.setImage(UIImage(named: "loop_all_icon"), forState: .Normal)
                break
            case .SingleSong:
                ModelButton.setImage(UIImage(named: "loop_single_icon"), forState: .Normal)
                break
            case .Shuffle:
                ModelButton.setImage(UIImage(named: "shuffle_icon"), forState: .Normal)
                break
            }
        }
    }
    var musicIsPlaying:Bool = false {
        didSet{
            if musicIsPlaying {
                PlayButton.setImage(UIImage(named: "big_pause_button"), forState: .Normal)
            }
            else
            {
                PlayButton.setImage(UIImage(named: "big_play_button"), forState: .Normal)
            }
            PlayButton.setNeedsDisplay()
        }
    }
    
    @IBOutlet weak var recordButton: UIButton!
    var player: EZAudioPlayer!
    var microphone: EZMicrophone!
    var recorder: EZRecorder!
    var isRecording = false
    var allowRecording = false
    var LRCDictionary: NSMutableDictionary!
    var timeArray: NSMutableArray!
    var lrcLineNumber = 0
    
    
    //MARK:- Re- Recommendation 
    let alert = CustomIOSAlertView()
    var recommendResult:[Song]?
    
    //MARK:- LifeCycle
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        PlayButton.setImage(UIImage(named: "big_play_button"), forState: .Normal)
        player = nil
        musicDurationTimer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(PlayViewController.updateSliderValue(_:)), userInfo: nil, repeats: true)
        alert.delegate = self
        originArray = [].mutableCopy() as! NSMutableArray
        randomArray = NSMutableArray.init(capacity: 0)
        addPanRecognizer()
        configureScoreUI()
        createStreamer()
        initTableView()
        navigationController?.navigationBarHidden = true
        guard currentIndex <= songs.count else {
            return
        }
        currentIndex = 0
        if !dontReloadMusic {
            return
        }
        originArray.removeAllObjects()
        loadOriginArray()

    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBarHidden = false
        dontReloadMusic = true
    }
    
    //MARK:- Private Init
    internal required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private init() {
        super.init(nibName: nil, bundle: nil)
    }
    //MARK:- Basic Setup
    func loadOriginArray() {
        if originArray.count == 0 {
            for (index,_) in songs.enumerate() {
                originArray.addObject(index)
            }
            if originArray.containsObject(currentIndex) {
                originArray.removeObject(currentIndex)
            }
        }
        
    }
    
    func setBackgroundImage () {
        let current = songs[currentIndex] as! Song
        var url = NSURL()
        if let imageurl = current.SongImage
        {
            url = NSURL(string: imageurl)!
        }
        else {
            url = NSURL(string:"")!
        }
        BackgroundImage.sd_setImageWithURL(url,placeholderImage: UIImage(named: "music_placeholder"))
        SongsImage.sd_setImageWithURL(url, placeholderImage: UIImage(named: "music_placeholder"))
        if !visualEffictView.isDescendantOfView(Background) {
            let blurEffect = UIBlurEffect(style: .Dark)
            visualEffictView = UIVisualEffectView(effect: blurEffect)
            visualEffictView.frame = view.bounds
            visualEffictView.frame.size.width += 20
            Background.addSubview(visualEffictView)
        }
        BackgroundImage.startTransitionAnimation()
        SongsImage.startTransitionAnimation()
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }

    func addPanRecognizer() {
        let gesture = UISwipeGestureRecognizer.init(target: self, action: #selector(PlayViewController.dismiss(_:)))
        gesture.direction = .Down
        view.addGestureRecognizer(gesture)
    }

    func configureScoreUI() {
        ScoreBackgroundView.backgroundColor = UIColor.clearColor()
        ScoreBackgroundView.color = UIColor.whiteColor()
        ScoreBackgroundView.plotType = EZPlotType.Buffer
        ScoreBackgroundView.shouldFill = true
        ScoreBackgroundView.shouldMirror = true
        ScoreBackgroundView.gain = 2.0
        StandardView.backgroundColor = UIColor.clearColor()
        StandardView.color = UIColor(red: 201/255, green: 38/255, blue: 58/255, alpha: 1.0)
        StandardView.plotType = .Buffer
        StandardView.shouldMirror = true
        StandardView.shouldFill = true
        StandardView.gain = 0.5
    }
    
    func convertTime(timer:NSTimeInterval) -> String {
        let time = Int(timer)
        let seconds = String(format: "%d",Int(Float(time)%60))
        let minutes =  String(format: "%d",Int((Float(time/60))%60))
        return "\(minutes):\(seconds)"
    }
    
    func updateUI() {
        StartTime.text = convertTime(player.currentTime)
        EndTime.text = convertTime(player.duration - player.currentTime)
    }
    
    func updateSliderValue (timer:NSTimer) {
        if player.state == .EndOfFile{
          //TODO:- No Disicion here
            player.pause()
            musicIsPlaying = false
        }
        if player.duration == 0.0 {
            MusicTimeSlider.setValue(0.0, animated: false)
        }
        else {
            if player.currentTime >=  player.duration {
                player.currentTime -= player.duration
            }
            MusicTimeSlider.setValue(Float(player.currentTime/player.duration), animated: true)
            updateUI()
        }
    }
    
    func startSinging() {
        microphone.startFetchingAudio()
        musicIsPlaying = true
        isReplay = false
        player.play()
    }
    
    func finishSing() {
        player.pause()
        musicIsPlaying = false
        microphone.stopFetchingAudio()
        isRecording = false
        if (recorder != nil) {
            recorder.closeAudioFile()
        }
        if !isReplay {
            Alert()
        }
    }
    
    
    
    //MARK:- Gesture
    @IBAction func ScoreStart(sender: UITapGestureRecognizer) {
        scoreModel = !scoreModel
        if scoreModel {
            ScoreBackgroundView.alpha = 1.0
            StandardView.alpha = 1.0
            SongsImage.alpha = 0.0
            singerLabel.alpha = 1.0
            originalLabel.alpha = 1.0
        }
        else {
            singerLabel.alpha = 0.0
            originalLabel.alpha = 0.0
            ScoreBackgroundView.alpha = 0.0
            StandardView.alpha = 0.0
            SongsImage.alpha = 1.0
        }
    }
    //MARK:- Action
    @IBAction func ShowList() {
        dontReloadMusic = true
    }
    
    @IBAction func dismiss(sender: UIButton) {
        navigationController?.dismissViewControllerAnimated(true , completion: {
            [weak self] in
            self!.dontReloadMusic = false
            })
    }
    
    @IBAction func Like(sender: UIButton) {
        HeartLike.heartAnimation()
        like = !like
    }
    
    @IBAction func changeModel(sender: UIButton) {
        switch playMode {
        case .Loop:
            playMode = .SingleSong
            break
        case .SingleSong:
            playMode = .Shuffle
            break
        case .Shuffle:
            playMode = .Loop
            break
        }
        
    }
    
    @IBAction func Play() {
        if musicIsPlaying {
            finishSing()
        }
        else {
          recordButtonClicked()
          startSinging()
        }
    }
    
    @IBAction func ChangePlayTime(sender: MusicSlider) {
        if player.state == .EndOfFile {
            nextSong()
        }
        player.currentTime = player.duration * Double(sender.value)
        updateUI()
    }
    
    @IBAction func preSong() {
        if songs.count == 1 {
            HUD.flash(.Label("已经是第一首歌曲"), delay: 1.0)
            return
        }
        if playMode == .Shuffle && songs.count > 2 {
            setupRandomMusic()
        }
        else
        {
            let firstIndex = 0
            if currentIndex == firstIndex || currentIndex >= songs.count {
                currentIndex = songs.count - 1
            }
            else
            {
                currentIndex -= 1
            }
        }
        isReplay = true
        Play()
        microphone = nil
        recorder = nil
        recordButtonClicked()
        createStreamer()
        initTableView()
        musicIsPlaying = false
    }
    
    @IBAction func nextSong() {
        if songs.count == 1 {
            HUD.flash(.Label("已经是最后一首歌曲"), delay: 1.0)
            return
        }
        if playMode == .Shuffle && songs.count > 2 {
            setupRandomMusic()
        }
        else
        {
            checkNextIndexValue()
        }
        isReplay = true
        Play()
        microphone = nil
        recorder = nil
        recordButtonClicked()
        createStreamer()
        initTableView()
        musicIsPlaying = false
    }
    
    func checkNextIndexValue() {
        let last = songs.count - 1
        if currentIndex == last || currentIndex >= songs.count {
            currentIndex = 0
        }
        else
        {
            currentIndex += 1
        }
    }
    
    func setupRandomMusic() {
        loadOriginArray()
        let random = Int(arc4random()) % originArray.count
        randomArray[0] = originArray[random]
        originArray[random] = originArray.lastObject!
        originArray.removeObject(originArray.lastObject!)
        currentIndex = randomArray[0].integerValue
    }
    
    func updaterSliderValue(timer:AnyObject) {
        if player.state == .EndOfFile {
            player.play()
        }
        
        if player.duration == 0.0 {
            MusicTimeSlider.setValue(0.0, animated: false)
        }
        else {
            if player.currentTime >= player.duration {
                player.currentTime -= (player.duration)
            }
            MusicTimeSlider.setValue(Float( player.currentTime/player.duration), animated: true)
            updateUI()
        }
        
    }
    
    func invalidMusicDurationTimer() {
        if musicDurationTimer!.valid {
            musicDurationTimer!.invalidate()
        }
        musicDurationTimer = nil
    }
    
    func createStreamer() {
        if specialIndex > 0 {
            currentIndex = specialIndex!
            specialIndex = 0
        }
        currentSong = songs[currentIndex] as? Song
        songTitl = currentSong?.SongName
        player = EZAudioPlayer(delegate: self)
        setBackgroundImage()
        HUD.show(.LabeledProgress(title: "下载资源中", subtitle: "..."))
        downloadMusic((currentSong?.SongURL)!) { (file, error) in
            if error == nil {
                self.player.playAudioFile(file)
                self.player.pause()
                self.delay(0, closure: {
                    HUD.hide(animated: true)
                    self.loadPreviousAndNextMusicImage()
                    self.configNowPlayingInfoCenter()
                    HUD.flash(.LabeledSuccess(title: "下载成功", subtitle: nil), delay: 1.0)
                })
            } else {
                HUD.flash(.LabeledError(title: nil, subtitle: "网络错误，请检查您的Wi-Fi设置"), delay: 2.0)
            }
        }
    }
    
    func removeStreamerObserver() {
        player.removeObserver(self, forKeyPath: "status")
        player.removeObserver(self, forKeyPath: "duration")
        player.removeObserver(self, forKeyPath: "bufferingRatio")
    }
    
    func addStreamerObserver() {
        player.addObserver(self, forKeyPath: "status", options: .New, context: kStatusKVOKey)
        player.addObserver(self, forKeyPath: "duration", options: .New, context: kDurationKVOKey)
        player.addObserver(self, forKeyPath: "bufferingRatio", options: .New, context: kBufferingRatioKVOKey)
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if context == kStatusKVOKey {
            performSelector(#selector(PlayViewController.updateStatus), onThread: NSThread.mainThread(), withObject: nil, waitUntilDone: false)
        }
        else if context == kDurationKVOKey {
            performSelector(#selector(PlayViewController.updateSliderValue(_:)), onThread: NSThread.mainThread(), withObject: nil, waitUntilDone: false)
        }
        else if context == kBufferingRatioKVOKey {
            performSelector(#selector(PlayViewController.updateBufferingStatus), onThread: NSThread.mainThread(), withObject: nil, waitUntilDone: false)
        }
        else {
            super.observeValueForKeyPath(keyPath, ofObject: object, change: change, context: context)
        }
    }
    
    func updateStatus() {
        musicIsPlaying = false
        musicIndicator.state = .Stopped
        switch player.state {
        case .Playing:
            musicIsPlaying = true
            musicIndicator.state = .Playing
            break
        case .Paused:
            break
        case .Seeking:
            break
        case .EndOfFile:
            if playMode == .SingleSong {
                player.play()
            }
            else {
               presentViewController(RecommendationViewController(), animated: true, completion: nil)
            }
            break
        case .ReadyToPlay:
            musicIndicator.state = .Playing
            break
        case .Unknown:
            break
        }
        updateMusicCellsState()
    }
    
    func updateMusicCellsState() {}
    
    func updateBufferingStatus()  {}
    
    func loadPreviousAndNextMusicImage () {
        SongHelper.cacheMusicCovorWithMusicEntities(songs, currentIndex: currentIndex)
    }
    
    func configNowPlayingInfoCenter (){
        if (NSClassFromString("MPNowPlayingInfoCenter") != nil) {
            let song = currentSong
            let audio = AVURLAsset(URL: NSURL(string:song!.SongURL!)! , options: nil)
            let audioDuration = CMTimeGetSeconds(audio.duration)
            let ablumWidth = ( UIScreen.mainScreen().bounds.width - 16 ) * 2
            let imageView = UIImageView(frame: CGRectMake(0, 0, ablumWidth, ablumWidth))
            let placeHolder = UIImage(named: "music_lock_screen_placeholder")
            let URL = BaseHandler.imageGet(song!.SongImage!, width: "\(ablumWidth)", height: "\(ablumWidth)")
            
            imageView.sd_setImageWithURL(URL, placeholderImage: placeHolder, completed: { (image, error, cacheType, iamgeURL) in
                if let theImage = image  {
                    let artWork = MPMediaItemArtwork(image: theImage)
                    imageView.contentMode = .ScaleAspectFill
                    MPNowPlayingInfoCenter.defaultCenter().nowPlayingInfo = [MPMediaItemPropertyTitle :song!.SongName!,
                        MPMediaItemPropertyArtist:song!.SongArtist!,
                        MPMediaItemPropertyAlbumTitle: self.songTitl!,
                        MPMediaItemPropertyPlaybackDuration:audioDuration, MPMediaItemPropertyArtwork: artWork]
                }
                else
                {
                    let artWork = MPMediaItemArtwork(image:placeHolder!)
                    imageView.contentMode = .ScaleAspectFill
                    MPNowPlayingInfoCenter.defaultCenter().nowPlayingInfo = [MPMediaItemPropertyTitle :song!.SongName!,
                        MPMediaItemPropertyArtist:song!.SongArtist!,
                        MPMediaItemPropertyAlbumTitle: self.songTitl!,
                        MPMediaItemPropertyPlaybackDuration:audioDuration, MPMediaItemPropertyArtwork: artWork]
                }
            })
        }
    }
    
    //MARK:- DataSource
    func configureVC(data:[Song],chooesIndex:Int) {
        songs = NSMutableArray(array:data)
        dontReloadMusic = true
        specialIndex = chooesIndex
    }
}

extension PlayViewController {
    
    @IBAction func recordButtonClicked() {
         configureRecord()
        if (recorder != nil ) {
            print("delegate:  \(self.recorder.delegate)")
        }
        allowRecording = !allowRecording
        if allowRecording {
            microphone.startFetchingAudio()
            recorder = EZRecorder(URL: testFilePathURL(), clientFormat: self.microphone.audioStreamBasicDescription(),
                                       fileType: .M4A, delegate: self)
        }
        self.isRecording = allowRecording
    }
    
    func configureRecord() {
        let session = AVAudioSession.sharedInstance()
        var error : NSError?
        
        do {
            try session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        } catch let specialError as NSError {
            print("Dim background error \(specialError)")
            error = specialError
        }
        
        if error != nil {
            print("Error setting up audio session category:\(error!.localizedDescription)")
        }
        
        do {
            try session.setActive(true)
        } catch let specialError as NSError {
            print("Dim background error \(specialError)")
            error = specialError
        }
        
        if error != nil {
            print("Error setting up audio session active:\(error!.localizedDescription)")
        }
        self.microphone = EZMicrophone(delegate: self)
        
        do {
            try session.overrideOutputAudioPort(.Speaker)
        }catch let specialError as NSError {
            print("Error overriding output to the speaker \(specialError.localizedDescription)")
            error = specialError
        }
        self.setupNotifications()
        print("File written to application sandbox's documents directory: \(self.testFilePathURL())")
    }
    
    func setupNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(PlayViewController.playerDidChangePlayState(_:)), name: "playerDidChangePlayState", object: self.player)
    }
    
    func playerDidChangePlayState(notificatoin: NSNotification) {
        dispatch_async(dispatch_get_main_queue()) {
            let player = notificatoin.object as! EZAudioPlayer
            let isPlaying = player.isPlaying
            if isPlaying {
                self.recorder.delegate = nil
            }
        }
    }
    
    func playerDidReachEndOfFile(notification: NSNotification) {}
    
    func testFilePathURL() -> NSURL {
        if let dir = applicationDocumentsDirectory() {
            return NSURL.fileURLWithPath("\(dir)/\(currentSong?.SongName!).m4a")
        }else {
            return NSURL.fileURLWithPath("\(applicationDocumentsDirectory())/\(currentSong?.SongName!).m4a")
        }
    }
    
    func applicationDocumentsDirectory() -> String? {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        if paths.count > 0 {
            return paths[0]
        }else {
            return nil
        }
    }
}

//MARK:- Record
extension PlayViewController: EZRecorderDelegate, EZAudioPlayerDelegate, EZMicrophoneDelegate {
    func recorderDidClose(recorder: EZRecorder!) {
        recorder.delegate = nil
    }
    
    func recorderUpdatedCurrentTime(recorder: EZRecorder!) {
        //TODO:改变时间
        dispatch_async(dispatch_get_main_queue()) {
        }
    }
    
    func audioPlayer(audioPlayer: EZAudioPlayer!, playedAudio buffer: UnsafeMutablePointer<UnsafeMutablePointer<Float>>, withBufferSize bufferSize: UInt32, withNumberOfChannels numberOfChannels: UInt32, inAudioFile audioFile: EZAudioFile!) {
        if player != nil {
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.StandardView.updateBuffer(buffer[0], withBufferSize: bufferSize);
            });
        }
    }
    
    func audioPlayer(audioPlayer: EZAudioPlayer!, updatedPosition framePosition: Int64, inAudioFile audioFile: EZAudioFile!) {
    }
    
    
    func microphone(microphone: EZMicrophone!, hasAudioReceived buffer: UnsafeMutablePointer<UnsafeMutablePointer<Float>>, withBufferSize bufferSize: UInt32, withNumberOfChannels numberOfChannels: UInt32) {
        if microphone != nil {
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.ScoreBackgroundView?.updateBuffer(buffer[0], withBufferSize: bufferSize);
            });
        }
    }
    
    func microphone(microphone: EZMicrophone!, hasBufferList bufferList: UnsafeMutablePointer<AudioBufferList>, withBufferSize bufferSize: UInt32, withNumberOfChannels numberOfChannels: UInt32) {
        if self.isRecording {
            self.recorder.appendDataFromBufferList(bufferList,
                                                   withBufferSize: bufferSize)
        }
        
    }
}

//MARK:- Lyrics
extension PlayViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == 1 {
            guard recommendResult != nil else {
                return 0
            }
            return (recommendResult?.count)!
        } else {
            return timeArray.count
        }
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if tableView.tag == 1 {
            let cell = SongLibraryCell(style: .Default, reuseIdentifier: "songLibraryCell", songName: "Ordinary", singerName: "Copeland", albumPic: UIImage(named: "AlbumPic_4")!)
            let url = recommendResult![indexPath.row].SongImage
            cell.album.sd_setImageWithURL(NSURL(string: url!), placeholderImage: UIImage(named: "AlbumPic_3")!)
            cell.songName.text = recommendResult![indexPath.row].SongName
            cell.singerName.text = recommendResult![indexPath.row].SongArtist
            return cell
        } else {
        let identifier = "cell"
        if let cell = tableView.dequeueReusableCellWithIdentifier(identifier) as? MyCell {
            
            if let str = LRCDictionary.objectForKey(timeArray[indexPath.row]) as? String {
                cell.textLabel?.text = str
                
            }else {
                cell.textLabel?.text = ""
            }
            if indexPath.row == lrcLineNumber {
                cell.textLabel?.textColor = UIColor(red: 247.0/255, green: 15.0/255, blue: 68.0/255, alpha: 1.0)
                cell.textLabel?.font = UIFont.systemFontOfSize(15)
            }else {
                cell.textLabel?.textColor = UIColor.whiteColor()
                cell.textLabel?.font = UIFont.systemFontOfSize(13)
            }
            return cell
        }else {
            let cell = MyCell(style: .Default, reuseIdentifier: identifier)
            if let str = LRCDictionary.objectForKey(timeArray[indexPath.row]) as? String {
                cell.textLabel?.text = str
                
            }else {
                cell.textLabel?.text = ""
            }
            if indexPath.row == lrcLineNumber {
                cell.textLabel?.textColor = UIColor(red: 247.0/255, green: 15.0/255, blue: 68.0/255, alpha: 1.0)
                cell.textLabel?.font = UIFont.systemFontOfSize(15)
            }else {
                cell.textLabel?.textColor = UIColor.whiteColor()
                cell.textLabel?.font = UIFont.systemFontOfSize(13)
            }
            return cell
            }
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if tableView.tag == 1 {
            return 64
        } else {
            return 35
        }
    }
    
    func initTableView() {
        NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: #selector(PlayViewController.showTime), userInfo: nil, repeats: true)
        lrcLineNumber = 0
        timeArray = NSMutableArray()
        LRCDictionary = NSMutableDictionary()
        //init lrc
        downloadLRC((currentSong?.SongLyrics)!) { (path, error) in
                let pathURL = (path! as NSString).substringFromIndex(7)
                let mo = DoModel.initSingleModel()
                do {
                    let str = try String(contentsOfFile: pathURL, encoding: NSUTF8StringEncoding)
                    let dic: NSDictionary = mo.LRCWithName(str)
                    self.LRCDictionary = NSMutableDictionary(dictionary: (dic.objectForKey("LRCDictionary") as! NSDictionary))
                    self.timeArray = NSMutableArray(array: dic["timeArray"] as! NSArray)
                    self.delay(0, closure: {
                        self.tableView.delegate = self
                        self.tableView.dataSource = self
                        self.tableView.backgroundColor = UIColor.clearColor()
                        self.tableView.separatorStyle = .None
                    })
                } catch  {
                HUD.flash(.LabeledError(title: nil, subtitle: "抱歉,暂无歌词"), delay: 1.0)
                self.delay(0, closure: {
                        self.tableView.delegate = self
                        self.tableView.dataSource = self
                        self.tableView.backgroundColor = UIColor.clearColor()
                        self.tableView.separatorStyle = .None
                    })
            }
            }
     
    }
    
    func showTime() {
     self.displayWord()
     let duration = player.duration
     let currentTime = player.currentTime
     if duration - currentTime < 0.1 {
            player.pause()
        }
    }
    
    func displayWord() {
        let mo  = DoModel.initSingleModel()
        let num = timeArray.count
        for i in 0..<num {
            let currentTime = mo.changeTime(timeArray[i] as! String)
            if i + 1 < timeArray.count {
                let currentTime1 = mo.changeTime(timeArray[i+1] as! String)
                if (UInt(player.currentTime) > currentTime && UInt(player.currentTime) < currentTime1) {
                    self.updateLRCTableView(i)
                    tableView.reloadData()
                    break
                }
            } else if UInt(player.currentTime) > currentTime {
                self.updateLRCTableView(i)
                tableView.reloadData()
                break
            }
        }
    }
    
    func updateLRCTableView(lineNumber: Int) {
        lrcLineNumber = lineNumber
        tableView.reloadData()
        if lineNumber > 0 {
            let indexPath = NSIndexPath(forRow: lineNumber, inSection: 0)
            tableView.selectRowAtIndexPath(indexPath, animated: true, scrollPosition: .Middle)
        }
    }
}

extension PlayViewController {
    func Alert() {
        HUD.show(.LabeledProgress(title: nil, subtitle: "推荐中...⏳"))
        Song.getRecommendation((User.currentUser().id?.stringValue)!, completion: {result,error in
            HUD.hide(animated: true)
            if error == nil {
                self.recommendResult = result
                HUD.flash(.Success, delay: 1.0)
                self.delay(0, closure: {
                    self.alert.backgroundColor = UIColor.GlobalMenuBlack()
                    self.alert.containerView = UIView(frame:  CGRectMake(0, 0, self.view.bounds.width - 60 , 450))
                    self.configureButton()
                    self.alert.containerView.addSubview(self.initScoreView())
                    self.alert.containerView.addSubview(self.initRecommendationTitle())
                    self.alert.containerView.addSubview(self.initReTableView())
                    self.alert.show()
                })
            }
            else {
               HUD.flash(.LabeledError(title: nil, subtitle: "网络错误，请检查您的Wi-Fi"), delay: 1.0)
            }
        })
    }
    
    //MARK:- Random Score
    func scoreR() -> Double {
        var basic = 70.00
        basic += Double(arc4random()%30)
        return basic
    }
    
    //MARK:- Init View & UI
    func initScoreView () -> UILabel {
        let scoreLabel = UILabel(frame:  CGRectMake(0,0,view.bounds.width - 60,60))
        let mark = scoreR()
        if mark >= 90 {
            scoreLabel.text = "本次得分为\(mark)分!太棒了,简直是专业歌手😍"
        } else if mark >= 80 {
            scoreLabel.text = "本次得分为\(mark)分!音准不错,再接再厉!😊"
        } else {
            scoreLabel.text = "本次得分为\(mark)分!有些地方还是有点瑕疵哦,加油!🤓"
        }
        scoreLabel.adjustsFontSizeToFitWidth = true
        scoreLabel.textAlignment = .Center
        scoreLabel.textColor = UIColor.GlobalRed()
        scoreLabel.backgroundColor = UIColor( red: 0.1569, green: 0.1333, blue: 0.1451, alpha: 1.0 )
        scoreLabel.layer.cornerRadius = 8
        scoreLabel.clipsToBounds = true
        return scoreLabel
    }
    
    func initRecommendationTitle () -> UILabel {
        let titleLabel = UILabel(frame:  CGRectMake(0,55,view.bounds.width - 60,60))
        titleLabel.text = "🎤Carols猜您还喜欢如下歌曲:"
        titleLabel.textColor = UIColor.whiteColor()
        titleLabel.textAlignment = .Center
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.backgroundColor = UIColor(red: 0.1569, green: 0.1333, blue: 0.1451, alpha: 1.0 )
        return titleLabel
    }
    
    func initReTableView() -> UITableView {
        let tableView = UITableView()
        tableView.tag = 1
        tableView.frame = CGRectMake(0, 115, view.bounds.width - 60 , 340)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor( red: 0.1569, green: 0.1333, blue: 0.1451, alpha: 1.0 )
        return tableView
    }
    
    func configureButton() {
      
        alert.buttonTitles = NSMutableArray(objects: "不用了，我要接着唱","回放我刚刚唱过的歌") as [AnyObject]
    }
    
    //MARK:- TableView DataSource & Delegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if tableView.tag == 1 {
            alert.close()
            configureVC(recommendResult!,chooesIndex: indexPath.row)
            createStreamer()
        }
    }
    
    func customIOS7dialogButtonTouchUpInside(alertView: AnyObject!, clickedButtonAtIndex buttonIndex: Int) {
        print(buttonIndex)
        if buttonIndex == 1 {
            print(self.testFilePathURL())
            let audioFile = EZAudioFile(URL: self.testFilePathURL())
            self.player.playAudioFile(audioFile)
            self.musicIsPlaying = true
            self.isReplay = true
        }
        alert.close()
    }
}

//MARK:- Download Func 
extension PlayViewController {
    //MARK:- Download Music
    func downloadMusic (url:String,completion:((EZAudioFile?,NSError?)-> Void)) {
        let destination = Alamofire.Request.suggestedDownloadDestination(
            directory: .DocumentDirectory,
            domain: .UserDomainMask
        )
        
        Alamofire.download(.GET, url, destination: destination)
            .progress { bytesRead, totalBytesRead, totalBytesExpectedToRead in
                print(totalBytesRead)
            }
            .response { request, response, _, error in
                print("fileURL: \(destination(NSURL(string: "")!, response!))")
                let path = NSURL(string:  "\(destination(NSURL(string: "")!, response!))")
                let file = EZAudioFile(URL:path)
                if file != nil {
                    completion(file,nil)
                } else {
                    completion(nil,error)
                }
        }
    }
    //MARK:- Download Lrc.
    func downloadLRC(url:String,completion:((String?,NSError?)-> Void)) {
        let destination = Alamofire.Request.suggestedDownloadDestination(
            directory: .DocumentDirectory,
            domain: .UserDomainMask
        )
        Alamofire.download(.GET, url, destination: destination)
            .progress { bytesRead, totalBytesRead, totalBytesExpectedToRead in
                print(totalBytesRead)
            }
            .response { request, response, _, error in
                guard response != nil else {
                    completion(nil,error)
                    return
                }
                print("fileURL: \(destination(NSURL(string: "")!, response!))")
                let path = "\(destination(NSURL(string: "")!, response!))"
                completion(path,error)
        }
    }
}