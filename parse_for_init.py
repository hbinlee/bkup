import re
import os
import sys
import subprocess
import time

if(len(sys.argv)<4):
#if(len(sys.argv)<5):
    print("*"*80)
    print("input path ; output path ; frame")# ; regEx")
    print("input path : you can put any of absolute/relative path")
    print("output path : same as input path")
    print("frame : argument of ffmpeg. for example, if you want to extract 30 frames per sec, type 30")
#    print("regEx : for labeling, input should be has a rule. type formal regular expression")
    print("*"*80)
    exit()

format_video=["avi"] # you can modify for an additional video format


stime=time.time() # time measure
path_in=sys.argv[1]
if '/' not in path_in[-1]:
    path_in=path_in+"/"
path_out=sys.argv[2]
if '/' not in path_out[-1]:
    path_out=path_out+"/"
path_log=path_out+"../logs/"
frame=sys.argv[3]
#regEx=re.compile(sys.argv[4])
#f=open("labels.txt",'w')
labels=[]
dirs=os.listdir(path_in)
count=len(dirs)

try:
    os.listdir(path_out)
except OSError as e:
    if(e.errno==2):
        subprocess.Popen(['mkdir','-m','755',path_out])

try:
    os.listdir(path_log)
except OSError as e:
    if(e.errno==2):
        subprocess.Popen(['mkdir','-m','755',path_log])

for files in dirs:
    no='err'
    tmp=files.split('.')
    if tmp[-1] not in format_video:
        print(files+" is not supported")
        count=count-1
    else:
#        tmp=regEx.search(files)
#        if tmp:
#            label=tmp.group()
#            if label not in labels:
#                labels.append(label)
#            no=labels.index(label)
#        else:
#            print("labeling "+files+" was failed since it was not matched to your regEx")
        mod=subprocess.Popen(['./parse_module.sh',path_in+files,frame,path_out],stdout=subprocess.PIPE)
        out,err=mod.communicate()



# refer : matlab -nosplash -nodisplay -nojvm -r "${command}" > 

#        out=(out.split('\n'))[0]
#    if type(no) is int:
#        images=os.listdir(path_out+out)
#        for image in images:
#            tmp=image.split('.')
#            if tmp[-1] is 'jpg':
#                tmp="% d\n" % no
#                line=image+tmp
#                f.write(line)
#
#f.close()  ## it was labeling task. refer for labeling module made newly as soon
print("Task has done. %d files extracted to image files(.jpg)" % count)
print("details were logged to each %sFILENAME.log" % path_log)
secs=int(time.time()-stime)
mins=secs//60
secs=secs%60
print("----- Task elapsed {0} mins {1} seconds -----".format(mins,secs))
exit()
