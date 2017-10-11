function el = friendInit(gameWidth, scrsz4, bigFish, friendname, iFriend, options)
    

    
    el = SpriteKit.Sprite(sprintf('archfriend%d', iFriend));
    el.initState('swim1', fullfile(options.locationImages, [friendname '_swim_a.png']), true);
    el.initState('swim2', fullfile(options.locationImages, [friendname '_swim_b.png']), true);
    el.initState('swim3', fullfile(options.locationImages, [friendname '_swim_a.png']), true);
    el.initState('swim4', fullfile(options.locationImages, [friendname '_swim_c.png']), true);
    imgInfo = imfinfo(fullfile(options.locationImages, [friendname '_talk_a.png']));
    addprop(el, 'width');
    el.width = round(imgInfo.Width/2);
    addprop(el, 'height');
    el.height = round(imgInfo.Height/2);
    el.Location = bigFish.arcAround2(:, iFriend)';
    
    cycleNext(el) % update object state (I think this is necessary to get animation started)
    
    addprop(el, 'd0');
    el.d0 = [gameWidth, scrsz4];
    addprop(el, 'trajectory');
    addprop(el, 'iter');
    el.iter = 1;
    addprop(el, 'key');
    el.key = iFriend;
    el.Scale = 0.3; % linspace(.3, 1, length(bigFish.availabe) 
    
    addprop(el, 'filename');
    el.filename = friendname;
    
    


end