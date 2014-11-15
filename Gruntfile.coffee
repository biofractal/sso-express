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

			npm:
				src: ['package.json']
				dest: 'iis/'

			iisnode:
				expand:true
				cwd: 'node'
				src: ['web.config', '.env']
				dest: 'iis/'

		coffee:
			node:
				files:
					'build/TestService.js': 'node/services/TestService.coffee'
					'build/TestRoutes.js': 'node/routes/TestRoutes.coffee'
					'build/node-server.js': 'node/node-server.coffee'

		watch:
			node:
				files: ['node/**/*.coffee']
				tasks: ['coffee:node', 'copy:node', 'clean:build']

		nodemon:
			dev:
				script: 'iis/node-server.js'
				options:
					ignore: ['node_modules/**', 'build/**']

		concurrent:
			local:
				tasks: ['watch:node']
				options:
					logConcurrentOutput: true
					limit:4

		open :
			dev :
				path: 'http://sso-express.localhost/sso/ping1'


	grunt.loadNpmTasks 'grunt-contrib-clean'
	grunt.loadNpmTasks 'grunt-contrib-copy'
	grunt.loadNpmTasks 'grunt-contrib-coffee'
	grunt.loadNpmTasks 'grunt-contrib-watch'
	grunt.loadNpmTasks 'grunt-nodemon'
	grunt.loadNpmTasks 'grunt-concurrent'
	grunt.loadNpmTasks 'grunt-open'

	grunt.registerTask 'default', ['clean', 'coffee:node', 'copy', 'clean:build', 'open', 'concurrent:local']


