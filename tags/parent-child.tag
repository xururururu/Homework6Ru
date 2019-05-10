<parent-child>
  <div class="memeTitle">
   Pikachu Library
 </div>

	<div class="memeMaker">
		<!-- ref or reference attribute is a quick way to "bookmark" an element so we can quickly access it in javascript later. -->
		<!-- E.g. HTML <img ref="xxx"/> -->
		<!-- E.g. JS this.refs.xxx points to the img tag prior -->
		<input type="text" ref="urlEl" placeholder="Enter url">
		<input type="text" ref="captionEl" placeholder="Enter caption">

    <input type="text" ref="funnyEl" placeholder="Enter funness (0 to 5)">

    <button type="button" onclick={ saveMeme }>Save Pikachu</button>
	</div>


  <div class="order">
    <p>order data by</p>
    <select ref="order" value="" onchange={ orderResults }>
      <option value="default">Default</option>
      <option value="funnees">Cute</option>
      <option value="caption">Caption</option>
    </select>
  </div>


  <div class="filter">
    <p>filter by level of cute</p>
    <select ref="fun" value="" onchange={ filterResults }>
      <option value="default">Default</option>
      <option value="nofun">No Cute</option>
      <option value="somewhatfun">Some Cute</option>
      <option value="veryfun">Very Cute</option>
    </select>
  </div>



	<div show={ myMemes.length == 0 }>
		<p>NO Pikachu</p>
	</div>

	<child each={ myMemes }>
	</child>

	<script>
		<!-- a js array to store all my Meme info -->
		console.log(this);

		this.myMemes = [	];

		var that  =  this;
    var memeRef = rootRef.child('meme');

		this.remove = function(event) {
			console.log('EVENT:', event);
			// console.log('EVENT.ITEM', event.item);
			var memeObj = event.item;
			//in this context, since this function is invoked by child.tag. so this == child

			var index = that.myMemes.indexOf(memeObj);
			//remember the remove button is called by child. so we cannot type this to refer to the parent
			//we have to give it a new name
			that.myMemes.splice(index, 1);
			//try to comment out this line and see what happens
			//in riot, js object data value only gets updated by user event trigger.
			//since in this case, event is triggered by child, parent data won't be updated until
			//we call it to update manually.
			that.update();
      var key = this.id;
      memeRef.child(key).remove();
		};

		// this.addMeme = function(event) {
		// 	console.log(event);
		// 	var url = this.refs.urlEl.value;
		// 	var caption = this.refs.captionEl.value;
		// 	var meme = { url: url, caption: caption };
		// 	// We are adding a book object to the source of truth array.
		// 	this.myMemes.push(meme);
		// 	// RESET INPUTS this.refs.urlEl.value = "";
		// 	this.refs.captionEl.value = "";
    //
    //
    //   ////
    //   var key = memeRef.push().key;
    //   console.log(key);
    //
    //   // Our data object that we will write to the database.
    //   // We could design this model to have other properties, like author.
    //   var meme = {
    //     url: this.refs.urlEl.value,
    //     caption: this.refs.captionEl.value,
    //
    //   };
    //
    //
    //   memeRef.push(meme);
    //
    //
    //
		// };



    memeRef.on('value', function(snap){
      let dataAsObj = snap.val();


      var tempData = [];

      //instead of statically typing out the array value, we now read it in
      //from the firebase data obj using a js for loop structure
      for (key in rawdata) {
        tempData.push(rawdata[key]);
      }

      //finally, we copy this array back to our tag's property field
      // console.log("myMemes", tag.myMemes);
      that.meme = tempData;

      //same question, 4th time of encounter. Why do we need to call tag update here?
      that.update();
      observable.trigger('updateMemes', tempData);
    });



    this.saveMeme = function(){
			var key = memeRef.push().key;
			console.log(key);

			// Our data object that we will write to the database.
			// We could design this model to have other properties, like author.
			var meme = {
        id: key,
        url: this.refs.urlEl.value,
        caption: this.refs.captionEl.value,
        funness: this.refs.funnyEl.value
			};
      this.myMemes.push(meme);
      memeRef.push(meme);
      memeRef.child(key).set(meme);

      //clean up default input values
      this.refs.urlEl.value = "";
      this.refs.captionEl.value = "";
      this.refs.funnyEl.value = "";
		//	memeRef.push(meme);
		}



    orderResults(event){
      //1. get order value
      let order = this.refs.order.value;
      // console.log("order", order);

      let orderResult = memeRef;
      console.log("memeRef", memeRef);

      if (order == "funnees"){
        orderResult = orderResult.orderByChild('funness');
        console.log("order by funness", orderResult);
      }else if(order == "caption"){
        orderResult = orderResult.orderByChild('caption');
      }else{
        // default, nothing happens
      }

      orderResult.once('value', function (snap) {
        // let rawdata = snap.val();
        // console.log("datafromfb", datafromfb);
        let tempData = [];

        snap.forEach(function(child) {
           tempData.push(child.val()); // NOW THE CHILDREN PRINT IN ORDER
       });

        that.myMemes = tempData;

        that.update();
        observable.trigger('updateMemes', tempData);
      });
    }



    filterResults(event) {
      //get current filter value
      var fun = this.refs.fun.value;
      //order memes by child property funnees
      let queryResult = memeRef.orderByChild('funness');
      console.log("queryResult", queryResult);

      //combine with additional functions to form complex queries
      if (fun == "nofun") {
        queryResult = queryResult.equalTo("0");
          console.log("queryResult for no fun", queryResult);
      } else if (fun == "veryfun") {
        queryResult = queryResult.equalTo("5");
        console.log("queryResult for very full", queryResult);
      } else if (fun == "somewhatfun") {
        queryResult = queryResult.startAt('1').endAt('4');
        console.log("queryResult for some fun", queryResult);
      } else {
        //default, no query needed
      }

      queryResult.once('value', function (snap) {
        let rawdata = snap.val();
        // console.log("datafromfb", datafromfb);
        let tempData = [];
        for (key in rawdata) {
          tempData.push(rawdata[key]);
        }
        // console.log("myMemes", tag.myMemes);
        that.myMemes = tempData;

        that.update();
        observable.trigger('updateMemes', tempData);
      });
    }
















	</script>

	<style>
		:scope {
      text-align: center;
			display: block;
			background: orange;
			padding: 15px;
		}
    .memeMaker{
      text-align: center;
      margin-bottom:20px;
    }
    .memeTitle{
      text-align: center;
      margin-bottom:20px;
      font-family: Arial , serif;
      font-size:60px;
    }
		img {
			width: 80%;
		}
	</style>

</parent-child>
