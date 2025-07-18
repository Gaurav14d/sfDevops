import { LightningElement, track } from 'lwc';
import getVideos from '@salesforce/apex/YTController.getYTVideos';
export default class YTSearchPlayer extends LightningElement {
     @track finalresult = [];
     @track finalError = '';
     @track searchInput = '';
     @track videoResults = [];
     @track viewUrl = '';
     //This method will be called on load of component 
     connectedCallback() {
          this.handleSubmit();
     }
     // If you wanted to do something when user is entering the string
     handleSearch(event) {
          this.searchInput = event.target.value;
          console.log('This is searchInput::' + this.searchInput);
     }
     //To map the videoResults to iframe and related list 
     handleSubmit() {
          getVideos({ searchKey: this.searchInput })
               .then((results) => {
                    console.log('This is final video results ::' + JSON.stringify(this.videoResults));

                    if (this.videoResults.length > 0) {
                         this.showVideoInFrame(this.videoResults[0].videoId);
                    }
               })
               .catch((error) => {
                    this.finalError = error.body.message;
                    console.log('This is final video results::' + this.finalError);
               })

     }

     //To show youtube video
     showVideoInIframe(videoId) {
          this.viewUrl = 'https://www.youtube.com/embed/' + videoId;
     }
     // Play video from related results
     watchVideo
     watchVideo(event) {
          let slt = event.currentTarget.dataset.id;
          console.log('This is selected video:' + slt);
          this.viewUrl = 'https://www.youtube.com/embed/' + slt;
     }
}