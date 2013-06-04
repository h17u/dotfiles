/*---------------------
	:: Comment 
	-> controller
---------------------*/
var CommentController = {

	// To trigger this action locally, visit: `http://localhost:port/comment/create`
	create: function (req,res) {

		// This will render the view: /Users/tommy/Dropbox/Project/mySails/views/comment/create.ejs
		res.view();

	},

	// To trigger this action locally, visit: `http://localhost:port/comment/destroy`
	destroy: function (req,res) {

		// This will render the view: /Users/tommy/Dropbox/Project/mySails/views/comment/destroy.ejs
		res.view();

	},

	// To trigger this action locally, visit: `http://localhost:port/comment/tag`
	tag: function (req,res) {

		// This will render the view: /Users/tommy/Dropbox/Project/mySails/views/comment/tag.ejs
		res.view();

	},

	// To trigger this action locally, visit: `http://localhost:port/comment/like`
	like: function (req,res) {

		// This will render the view: /Users/tommy/Dropbox/Project/mySails/views/comment/like.ejs
		res.view();

	}

};
module.exports = CommentController;