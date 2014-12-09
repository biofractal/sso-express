module.exports = (grunt) ->
	grunt.initConfig

		clean:
			build:['build']

		copy:
			node:
				expand:true
				cwd: 'build'
				src: ['**/*.*']
				dest: 'iis'

			cert:
				flatten:true
				expand:true
				cwd: 'saml'
				src: ['**/*.key']
				dest: 'iis/'

			npm:
				src: ['package.json']
				dest: 'iis/'

			iisnode:
				expand:true
				cwd: 'node'
				src: ['web.config', '.env']
				dest: 'iis/'

		coffee:
			dev:
				sourceMap: true
				expand: true
				flatten: true
				cwd: './'
				src: ['angular/**/*.coffee', 'node/**/*.coffee']
				dest: 'build/'
				ext: '.js'

		jade:
			dist:
				expand: true
				flatten:true
				src: ['./angular/**/*.jade']
				dest: 'build'
				ext: '.html'

		watch:
			coffee:
				files: ['**/*.coffee', '**/*.jade', '!Gruntfile.coffee']
				tasks: ['build']

		concurrent:
			build:
				tasks: ['coffee', 'jade']
				options:
					logConcurrentOutput: true
					limit:4
			local:
				tasks: ['watch']
				options:
					logConcurrentOutput: true
					limit:4

		open :
			dev :
				path: 'http://sso-express.localhost/#/home'
				#path: 'http://sso-express.localhost/api/sso/openidp/initiate/saml'
				#path: 'http://sso-express.localhost/api/sso/testshib/initiate/saml'
				#path: 'http://sso-express.localhost/api/sso/ssocircle/initiate/saml'


	grunt.loadNpmTasks 'grunt-contrib-clean'
	grunt.loadNpmTasks 'grunt-contrib-copy'
	grunt.loadNpmTasks 'grunt-contrib-coffee'
	grunt.loadNpmTasks 'grunt-contrib-jade'
	grunt.loadNpmTasks 'grunt-contrib-watch'
	grunt.loadNpmTasks 'grunt-concurrent'
	grunt.loadNpmTasks 'grunt-open'

	grunt.registerTask 'build',   ['concurrent:build', 'copy','clean']
	grunt.registerTask 'default', ['build', 'open', 'concurrent:local']


