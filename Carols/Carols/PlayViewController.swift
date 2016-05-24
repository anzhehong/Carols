//
//  ViewController.swift
//  LXDMusicPlayer
//
//  Created by  Harold LIU on 5/5/16.
//  Copyright © 2016 Tongji Apple Club. All rights reserved.
//

import UIKit
import DOUAudioStreamer
import SDWebImage
import MediaPlayer

enum PlayMode {
    case SingleSong
    case Loop
    case Shuffle
}


let kStatusKVOKey = UnsafeMutablePointer<(Void)>()
let kDurationKVOKey = UnsafeMutablePointer<(Void)>()
let kBufferingRatioKVOKey = UnsafeMutablePointer<()>()

protocol PlaySongDelegate {
    func PlayListDataSource (songs:[Song]) -> Bool;
    func CurrentPlaying () -> Song;
    func PlayMusicWithCurrentIndex(idnex:Int)
}

class PlayViewController: UIViewController{

    //MARK:- Let PlayView be Signton
    class var sharedInstance: PlayViewController {
        struct Static {
            static var onceToken: dispatch_once_t = 0
            static var instance: PlayViewController? = nil
        }
        dispatch_once(&Static.onceToken) {
            Static.instance = PlayViewController()
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
    
    @IBOutlet weak var LyricView: UIView!
//MARK:- Params
    var streamer :DOUAudioStreamer?
    var dontReloadMusic:Bool = false
    var songs = NSMutableArray()
    var currentSong:Song?
    var songTitle:String?
    var artistName:String?
    var specialIndex:Int?
    var parentId:NSNumber?
    var isNotPresenting:Bool?
    var like:Bool = false
   // let delegate:PlaySongDelegate
    
    var visualEffictView = UIVisualEffectView()
    let musicIndicator = MusicIndicator.sharedInstance
    var lastMusicURL = ""
    
    var randomArray = NSMutableArray()
    var originArray = NSMutableArray()
    var musicDurationTimer:NSTimer?
    var playMode = PlayMode.Loop
    var musicIsPlaying:Bool = true {
        didSet{
            if musicIsPlaying {
                PlayButton.setImage(UIImage(named: "big_pause_button"), forState: .Normal)
            }
            else
            {
                PlayButton.setImage(UIImage(named: "big_play_button"), forState: .Normal)
            }
            view.setNeedsDisplay()
        }
    }
    var currentIndex:Int = 0
    
//MARK:- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        streamer = DOUAudioStreamer()
        musicDurationTimer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(PlayViewController.updateSliderValue(_:)), userInfo: nil, repeats: true)
        currentIndex = 0
        originArray = [].mutableCopy() as! NSMutableArray
        randomArray = NSMutableArray.init(capacity: 0)
        addPanRecognizer()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBarHidden = true
        playMode = .Loop
        setupRadioMusic()
        if !dontReloadMusic {
            return
        }
        originArray.removeAllObjects()
        loadOriginArray()
        createStreamer()
    }
    
    override func viewDidAppear(animated: Bool) {
        print(currentSong)
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
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
//MARK:- Check Index
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
    
    func setterCurrentIndex(index:Int) {
        currentIndex = index
        setupMusicView(songs[index] as! Song)
    }
    
    func setupMusicView(song:Song) {
        currentSong = song
        songTitle = currentSong?.SongName
        artistName = currentSong?.SongArtist
        setBackgroundImage()
        checkHeartIcon()
    }
    
    func setPlayMode(mode:PlayMode) {
        playMode = mode
        updateModeButton()
    }
    
    func updateModeButton() {
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

    func setupRadioMusic() {
        updateModeButton()
        checkIndex()
    }
    
    func checkHeartIcon() {
        if like {
            HeartLike.setImage(UIImage(named:"red_heart"), forState: .Normal)
        }
        else {
            HeartLike.setImage(UIImage(named:"empty_heart"), forState: .Normal)
        }
    }
    
    func checkIndex()
    {
        guard currentIndex >= songs.count else {
            return
        }
            currentIndex = 0
    }
    
    func setBackgroundImage () {
        let width = String(Int((UIScreen.mainScreen().bounds.width - 70) * 2))
        let url = BaseHandler.imageGet((currentSong?.SongImage)!, width: width, height: width)
        BackgroundImage.sd_setImageWithURL(url)
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
    
//MARK:- Basic Setup
    func addPanRecognizer() {
       let gesture = UISwipeGestureRecognizer.init(target: self, action: #selector(PlayViewController.dismiss(_:)))
        gesture.direction = .Down
        view.addGestureRecognizer(gesture)
    }
   
    func updateUI() {
        StartTime.text = String(streamer!.currentTime)
        EndTime.text = String(streamer!.duration)
    }
    
    func updateSliderValue (timer:NSTimer) {
        if streamer!.status == .Finished {
            streamer!.play()
        }
        
        if streamer!.duration == 0.0 {
            MusicTimeSlider.setValue(0.0, animated: false)
        }
        else {
            if streamer!.currentTime >= streamer!.duration {
                streamer!.currentTime -= streamer!.duration
            }
            
            MusicTimeSlider.setValue(Float(streamer!.currentTime/streamer!.duration), animated: true)
            updateUI()
        }
    }
//MARK:- Gesture
    

//MARK:- Action
    @IBAction func ShowList() {
       dontReloadMusic = true
    }
    
    @IBAction func dismiss(sender: UIButton) {
     
        navigationController?.dismissViewControllerAnimated(true , completion: {
            [weak self] in
            self!.dontReloadMusic = false
     //       self!.lastMusicURL = self.currentPlaying()?.SongURL
        })
    }
    
    @IBAction func Like(sender: UIButton) {
        HeartLike.heartAnimation()
        if like {
            unlike()
        }
        else {
            toLike()
        }
    }
    
    @IBAction func changeModel(sender: UIButton) {
        switch playMode {
        case .Loop:
            playMode = .SingleSong
            sender.setImage(UIImage(named: "loop_single_icon"), forState: .Normal)
            break
        case .SingleSong:
            playMode = .Shuffle
            sender.setImage(UIImage(named: "shuffle_icon"), forState: .Normal)
            break
        case .Shuffle:
            playMode = .Loop
            sender.setImage(UIImage(named: "loop_all_icon"), forState: .Normal)
            break
        }
        
    }
    
    func PlayMusicWithCurrentIndex(idnex:Int) {
        currentIndex = idnex
        createStreamer()
    }
    
    @IBAction func Play() {
        if musicIsPlaying {
            streamer!.pause()
            musicIsPlaying = false
        }
        else {
            streamer!.play()
            musicIsPlaying = true
        }
    }
    
    @IBAction func ChangePlayTime(sender: MusicSlider) {
        if streamer!.status == .Finished {
            streamer = nil
            createStreamer()
        }
        streamer!.currentTime = streamer!.duration * Double(sender.value)
        updateProgressLabelValue()
    }
    
    @IBAction func preSong() {
        if songs.count == 1 {
            print("已经是第一首歌曲")
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
        setupStreamer()
    }
    
    @IBAction func more() {
        print("More")
    }
    
    @IBAction func nextSong() {
        if songs.count == 1 {
            print("已经是最后一首歌曲")
            return
        }
        if playMode == .Shuffle && songs.count > 2 {
            setupRandomMusic()
        }
        else
        {
          checkNextIndexValue()
        }
        setupStreamer()
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
  
    func setupStreamer() {
        createStreamer()
    }

    func updaterSliderValue(timer:AnyObject) {
        
        if streamer!.status == .Finished {
            streamer?.play()
        }
        
        if streamer?.duration == 0.0 {
            MusicTimeSlider.setValue(0.0, animated: false)
        }
        else {
            if streamer?.currentTime >= streamer?.duration {
                streamer?.currentTime -= (streamer?.duration)!
            }
            
            MusicTimeSlider.setValue(Float( streamer!.currentTime/streamer!.duration), animated: true)
            updateProgressLabelValue()
        }
        
    }
    
    func updateProgressLabelValue() {
        StartTime.text = "\(streamer!.currentTime)"
        EndTime.text = "\(streamer!.duration)"
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
        setupMusicView(songs[currentIndex] as! Song)
        loadPreviousAndNextMusicImage()
        configNowPlayingInfoCenter()
        let stream = Stream()
        //TODO:- Change to network Path Here
        //let musicURL = NSURL(string: "")
        let filePath = NSBundle.mainBundle().pathForResource(currentSong?.SongFile, ofType: "mp3")
        let fileURL = NSURL(fileURLWithPath: filePath!)
        stream.taudioFileURL = fileURL
        streamer = nil
        streamer = DOUAudioStreamer(audioFile: stream)
        streamer?.play()
    }
    
    func removeStreamerObserver() {
        streamer?.removeObserver(self, forKeyPath: "status")
        streamer?.removeObserver(self, forKeyPath: "duration")
        streamer?.removeObserver(self, forKeyPath: "bufferingRatio")
    }
    
    func addStreamerObserver() {
        streamer?.addObserver(self, forKeyPath: "status", options: .New, context: kStatusKVOKey)
        streamer?.addObserver(self, forKeyPath: "duration", options: .New, context: kDurationKVOKey)
        streamer?.addObserver(self, forKeyPath: "bufferingRatio", options: .New, context: kBufferingRatioKVOKey)
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
        
        switch streamer!.status {
        case .Playing:
            musicIsPlaying = true
            musicIndicator.state = .Playing
            break
        case .Paused:
            break
        case .Idle:
            break
        case .Finished:
            if playMode == .SingleSong {
                streamer?.play()
            }
            else {
                nextSong()
            }
            break
        case .Buffering:
            musicIndicator.state = .Playing
            break
        case .Error:
            break
        }
        updateMusicCellsState()
    }
    
    func  toLike() {
        like = true
        HeartLike.setImage(UIImage(named: "red_heart"), forState: .Normal)
    }
    
    func unlike() {
        like = false
        HeartLike.setImage(UIImage(named: "empty_heart"), forState: .Normal)
    }
    
    func updateMusicCellsState() {
    }
    
    func updateBufferingStatus()  {
    }
    
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
                        MPMediaItemPropertyAlbumTitle: self.songTitle!,
                        MPMediaItemPropertyPlaybackDuration:audioDuration, MPMediaItemPropertyArtwork: artWork]
                }
                else
                {
                    let artWork = MPMediaItemArtwork(image:placeHolder!)
                    imageView.contentMode = .ScaleAspectFill
                    MPNowPlayingInfoCenter.defaultCenter().nowPlayingInfo = [MPMediaItemPropertyTitle :song!.SongName!,
                        MPMediaItemPropertyArtist:song!.SongArtist!,
                        MPMediaItemPropertyAlbumTitle: self.songTitle!,
                        MPMediaItemPropertyPlaybackDuration:audioDuration, MPMediaItemPropertyArtwork: artWork]
                }
                //TODO:- @()
            })
        }
    }
    
    //MARK:- DataSource 
    func setVCData (pathName:String,type:String,chooseIndex:Int){
        //TODO: Chane to Net URL
        //let URL = NSURL(string: "")
        let filePath = NSBundle.mainBundle().pathForResource(pathName, ofType: type)
        let result = try! NSJSONSerialization.JSONObjectWithData(NSData(contentsOfFile: filePath!)!, options:.MutableContainers) as! NSDictionary
        let array = result["data"]!.mutableCopy() as! NSArray
        let mutableArray = NSMutableArray(array: Song.entitiesArrayFromArray(array)!)
        songs = mutableArray
        dontReloadMusic = true
        specialIndex = chooseIndex
    }
}

