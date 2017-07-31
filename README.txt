%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% This script is part of a application about actions recognition.
% Created by Israel Goncalves de Oliveira (prof.israel@gmail.com) for
% investigate the performance of multilinear methods to representate the 
% data and classify. The professor advisor is Jacob Schakanski 
% (jacobs@inf.ufrgs.br). The authors are part of the Singnal Process and
% Instrumentation group from PPGEE (Pos-graduacao em Egenharia Eletrica:
% http://www.ufrgs.br/ppgee/) and the Pattern Recognition group from PPGC 
% (Pos-graduacao em Ccomputacao: https://www.inf.ufrgs.br/ppgc/). 
% 
%
% Versions format: Foo Bar (foo@bar.com) X.X.DDMMYYYY "A comment".
% Israel Oliveira (prof.israel@gmail.com) 1.0.XXXX2017. "The first version"
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



This app is about pattern recognition. The mean idea is to compare linear and
multilinear methods to recognize a actions perfomed by a person using HDM5 (Muller et all, 2007) database.

We use three different datasets from the same database: A) 3D interpoled and normalize motion of the all jonits; B) the 2D version of the A (Ofli et all, 2014) and C) the same B but with all joints (IS NOT FISIABLE!).



All results are like results_MDA.mat with R (general results), MC (matrix confusion), num_max (max dimensionality for each dimension) and E (convergence error).

The 2D version is obtained 

Evanglids 2012, angulos das juntas (joint angles).





[Muller et all, 2007]
About HDM5: <http://www.mpi-inf.mpg.de/resources/HDM05>.
If you use and publish results based on this code and data, please cite the following
technical report:
   @techreport{MuellerRCEKW07_HDM05-Docu,
     author = {Meinard M{\"u}ller and Tido R{\"o}der and Michael Clausen and Bernd Eberhardt and Bj{\"o}rn Kr{\"u}ger and Andreas Weber},
     title = {Documentation: Mocap Database {HDM05}},
     institution = {Universit{\"a}t Bonn},
     number = {CG-2007-2},
     year = {2007}
   }


[Ofli et all, 2014]
@article{Ofli201424,
title = "Sequence of the most informative joints (SMIJ): A new representation for human skeletal action recognition ",
journal = "Journal of Visual Communication and Image Representation ",
volume = "25",
number = "1",
pages = "24 - 38",
year = "2014",
note = "Visual Understanding and Applications with RGB-D Cameras ",
issn = "1047-3203",
doi = "http://doi.org/10.1016/j.jvcir.2013.04.007",
url = "http://www.sciencedirect.com/science/article/pii/S1047320313000680",
author = "Ferda Ofli and Rizwan Chaudhry and Gregorij Kurillo and René Vidal and Ruzena Bajcsy"
}


A good site:
http://www.cad.zju.edu.cn/home/dengcai/Data/DimensionReduction.html




It was observed tha GAP method converges to a max performance inherit the incitial random samplpes! See 'prova_search_GAP.mat'.

Alternative databases: Berkley MHAD. One dataset using 3D positions (like HDM05) of 43 markers and other using data from 6 accelerometers. http://tele-immersion.citris-uc.org/berkeley_mhad
For create the 3rd-order tensor dataset (D) is ready! But for other is important to aply the SMIJ teory.
for that we must read and learn more about the joints and 3D-points from de Mocap.

This base have a good demos for depth and image view of the motion.

Other method:

@inproceedings{zhang2016, 
      title={A Large Scale RGB-D Dataset for Action Recognition},
      author={Zhang, Jing and Li, Wanqing and Wang, Pichao and Ogunbona, Philip and Liu, Song and Tang, Chang},
      booktitle={International Workshop on Understanding Human Activities through 3D Sensors (UHA3DS'16) in conjunction with 23rd International Conference on Pattern Recognition (ICPR2016)},
      year={2016},
}

MSRAction3DDatasets:
http://www.uow.edu.au/~wanqing/#MSRAction3DDatasets

HON4D
http://www.cs.ucf.edu/~oreifej/HON4D.html


See http://vision.imar.ro/human3.6m/description.php

See http://mocap.cs.cmu.edu/

