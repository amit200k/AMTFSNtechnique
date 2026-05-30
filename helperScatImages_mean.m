function features = helperScatImages_mean(sn,x)
smat = featureMatrix(sn,x);
features = mean(smat,2:4);
features = features';
end