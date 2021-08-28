# Recorder  
  
This is a flutter application for a demonstrating bloc pattern architecture and audio recording functionality.  
## APK Link 
[Android apk download link](https://drive.google.com/file/d/1Zb2Rjol-VfxpG4fF10PgVMAf1wA4aF_R/view?usp=sharing)


## Project Structure  
  
- **.screens** : All the main screens for the app goes into this package  
- **.blocs** : All business logic is inside these files 
- **.components** : All reusable widgets are stored in this package  
  - **.atoms** : Atoms are completely stateless reusable components.  
  - **.molecules** : Molecules are stateful reusable components.  
  - **.organisms** : Organisms have their own state,bloc and probably won't be used again.  
- **.models** : All the blueprint files for the app goes into this package  
- **.services** : All classes which provides additional help goes in this package  
- **.assets** : All external images and fonts are stored here  
  
## Third party packages used in the project  
  
- **flutter_sound_lite** : Used for recording and playing sounds  
- **flutter_bloc** : Used for separating business logic from ui code
- **permission_handler** : Manage Microphone permissions
- **stop_watch_timer** : Keep track of audio record/play time
- **intl** : Date formatting
- **just_audio** : Playing recorded audio
- **path_provider** : Used for getting the path of temp directory

