/*---------------------
	:: Hello 
	-> controller
---------------------*/
var HelloController = {

	// To trigger this action locally, visit: `http://localhost:port/hello/index`
    index: function (req,res) {
          return res.view({ users: [{name: 'taro'}, {name: 'hanako'},{name: 'mike'}] });
      }

		// This will render the view: /Users/tommy/Dropbox/Project/mySails/views/hello/index.ejs
//		res.view();

//	}

};
module.exports = HelloController;
