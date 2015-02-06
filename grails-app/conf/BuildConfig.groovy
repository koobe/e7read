grails.servlet.version = "3.0" // Change depending on target container compliance (2.5 or 3.0)
grails.project.class.dir = "target/classes"
grails.project.test.class.dir = "target/test-classes"
grails.project.test.reports.dir = "target/test-reports"
grails.project.work.dir = "target/work"
grails.project.target.level = 1.6
grails.project.source.level = 1.6
//grails.project.war.file = "target/${appName}-${appVersion}.war"
grails.project.war.file = "target/kgleditor-${appVersion}.war"

grails.project.fork = [
    // configure settings for compilation JVM, note that if you alter the Groovy version forked compilation is required
    //  compile: [maxMemory: 256, minMemory: 64, debug: false, maxPerm: 256, daemon:true],

    // configure settings for the test-app JVM, uses the daemon by default
    test: [maxMemory: 768, minMemory: 64, debug: false, maxPerm: 256, daemon:true],
    // configure settings for the run-app JVM
    run: [maxMemory: 768, minMemory: 64, debug: false, maxPerm: 256, forkReserve:false],
    // configure settings for the run-war JVM
    war: [maxMemory: 768, minMemory: 64, debug: false, maxPerm: 256, forkReserve:false],
    // configure settings for the Console UI JVM
    console: [maxMemory: 768, minMemory: 64, debug: false, maxPerm: 256]
]

grails.project.dependency.resolver = "maven" // or ivy
grails.project.dependency.resolution = {
    // inherit Grails' default dependencies
    inherits("global") {
        // specify dependency exclusions here; for example, uncomment this to disable ehcache:
        // excludes 'ehcache'
    }
    log "error" // log level of Ivy resolver, either 'error', 'warn', 'info', 'debug' or 'verbose'
    checksums true // Whether to verify checksums on resolve
    legacyResolve false // whether to do a secondary resolve on plugin installation, not advised and here for backwards compatibility

    repositories {
        inherits true // Whether to inherit repository definitions from plugins

        grailsPlugins()
        grailsHome()
        mavenLocal()
        grailsCentral()
        mavenCentral()
        // uncomment these (or add new ones) to enable remote dependency resolution from public Maven repositories
        //mavenRepo "http://repository.codehaus.org"
        //mavenRepo "http://download.java.net/maven/2/"
        //mavenRepo "http://repository.jboss.com/maven2/"

        // Obtains scribe framework
        //mavenRepo "http://repo.desirableobjects.co.uk/"
        mavenRepo 'http://codenvycorp.com/repository/'
    }

    dependencies {
        // specify dependencies here under either 'build', 'compile', 'runtime', 'test' or 'provided' scopes e.g.
        runtime 'mysql:mysql-connector-java:5.1.29'
        //runtime 'mysql:mysql-connector-java:5.1.31'
        // runtime 'org.postgresql:postgresql:9.3-1101-jdbc41'

        compile "org.springframework:spring-orm:$springVersion"

        // OAuth required scribe framework
        //runtime "org.scribe:scribe:1.3.5"

        // AWS ...
        runtime 'com.amazonaws:aws-java-sdk:1.7.12'

        // jsoup
        runtime 'org.jsoup:jsoup:1.7.3'
		
		// compile 'com.microsoft.sqlserver:sqljdbc4:4.0'

        // Thumbnailator - a thumbnail generation library for Java
        compile 'net.coobird:thumbnailator:0.4.7'
        //compile 'org.imgscalr:imgscalr-lib:4.2'

        // for markdown plugin dependencies
        //runtime 'org.parboiled:parboiled-core:1.1.6'
        //runtime 'org.parboiled:parboiled-java:1.1.6'
        runtime 'org.pegdown:pegdown:1.4.2'
		
		// There is a known issue in hibernate4:4.3.6.1 plugin with the auto-timestamping feature. The workaround is to add these dependencies to BuildConfig.groovy:
//		compile "javax.validation:validation-api:1.1.0.Final"
//		runtime "org.hibernate:hibernate-validator:5.0.3.Final"
    }

    plugins {
        // plugins for the build system only
        build ":tomcat:7.0.55"

        // plugins for the compile step
        compile ":scaffolding:2.1.2"
        compile ':cache:1.1.8'
        compile ":asset-pipeline:1.9.9"

        // plugins needed at runtime but not for compilation
        runtime ":hibernate4:4.3.5.5" // or ":hibernate:3.6.10.15"
        runtime ":database-migration:1.4.0"
        runtime ":jquery:1.11.1"
		

        // OAuth
        //compile ":oauth:2.5"
            //exclude "scribe"

        // Spring Security
        compile ":spring-security-core:2.0-RC4"
        //compile "org.grails.plugins:spring-security-facebook:0.15.2-CORE2"
        compile ":spring-security-oauth:2.1.0-SNAPSHOT"
        compile ":spring-security-oauth-facebook:0.2"

        // Twitter Bootstrap
        runtime ":twitter-bootstrap:3.3.1"

        // Uncomment these to enable additional asset-pipeline capabilities
        //compile ":sass-asset-pipeline:1.9.1"
        //compile ":less-asset-pipeline:1.7.0"
        //compile ":coffee-asset-pipeline:1.7.0"
        //compile ":handlebars-asset-pipeline:1.3.0.3"

        // CKEditor Web-based WYSIWYG editor
        compile ":ckeditor:4.4.1.0"

        // AWS BeansTalk
        compile ":aws-elastic-beanstalk:0.2"

        // Grails Resources Plugin
        //runtime ':resources:1.2.8'

        compile ":elasticsearch:0.0.3.7"
        //compile ":searchable:0.6.8"
		
		// markdown plugin
		compile (":markdown:1.1.1") {
            //excludes 'asm', 'asm-util', 'asm-tree', 'asm-analysis'
            //excludes 'parboiled-core', 'parboiled-java'
            excludes 'pegdown'
        }

        // Provides Mail support to a running Grails application
        compile ":mail:1.0.7"

        // Grails GeoIP Plugin
        // Disabled. See #48 issue for reasons.
        //compile ':geoip:0.3.2'

        // Google GeoCoding API
        compile ":geocode:0.3"
   }
}
