function shutdown(){
	db.adminCommand({shutdown : 1, force : true})
}

shutdown();