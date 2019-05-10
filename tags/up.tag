<morning>




  <div if={!userInfo }>
    <label>Enter Your Name:</label>
    <input type="text" ref="userName" placeholder="RX"/>
    <button onclick={ userLogin }>Confirm</button>
  </div>


  <div if={userInfo}>
      <h1>Give {userInfo.userName}. Pikachu</h1>
      <button onclick={ userLogout }>Change Name</button>
        <button onclick={ GetUp }>Get Pikachu!</button>
  </div>









  <style>
    :scope {
      display: block;
    }

    .userInfo {
      background-color: yellow;

      display: inline-block;
      border: 1px solid #CCC;
      border-radius: 6px;
      margin: 2px;
      padding: 10px;
    }
    .meme{
      background-color: black;

      display: inline-block;
      border: 1px solid #CCC;
      border-radius: 6px;
      margin-top: 50px;
      padding: 10px;
    }
    img{

      margin: 20px;
      padding: 10px;
    }
  </style>







  <img src="img/{ myImage }.gif">


  <div>
    <div class="bar hunger">

    </div>

  </div>




  <div class="meme">
    <button type="button" onclick={ openMeme }>Open Pikachu Library</button>
  </div>





  <script>
  this.userLogin = function(e){
       this.userInfo = {
         userName: this.refs.userName.value,
       }
     }
  this.userLogout = function(e){
            this.userInfo = false;

          }
  this.openMeme = function(){
          window.location.assign('meme.html');

                  }













    //make a copy of my pet object and call it that

    var that  = this;

    //initial state
    this.up = 0;
    this.myImage = "pikachuhappy";

    //tell DOM window to increase hunger every three second
    //console.log(that);
    window.setInterval(function(){
      that.decUp();
      console.log("wait");
      that.update();
      that.checkStatus();
      <!-- console.log(this); -->
    }, 3000);


    decUp() {
    /*  js if statement shorthand   */
      this.up = this.up - 70 < 0 ? 0 : this.up - 70;
    }

    incUp() {
      console.log(this.up);
      this.up = this.up + 10 > 100 ? 100 : this.up + 2;
    }

    checkStatus() {
      if (this.up >= 80){
        this.myImage = "awake";
      } else if (this.up <= 10){
        this.myImage = "pikachuhappy";
      }else{
        this.myImage = "gettingUp";
      }
    }

// functions that respond to events

    GetUp(e) {
      this.incUp();
      this.checkStatus();
    }
  </script>

  <style>
  /* styles that will be applied to the root level of my tag*/
  :scope{
    margin:auto;
  }

  img{
    weight:auto;
    height:200px;
  }

  </style>
</morning>
