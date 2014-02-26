== README

This README would normally document whatever steps are necessary to get the
application up and running.

### Heorku:
 http://company-portal.herokuapp.com/

### Ruby version
ruby 1.9.3p0 (2011-10-30 revision 33570) [x86_64-linux]
Rails 4.0.2

### System dependencies
	sudo apt-get install ruby1.9.3
	sudo apt-get install postgresql
	sudo apt-get install libpq-dev
	sudo gem install rails
git clone "https://github.com/Nico321/Company-Portal.git"
### How to fix ruby racer install error
	1. gem uninstall libv8
	2. gem uninstall therubyracer
	3. sudo apt-get update
	4. sudo apt-get install libv8-dev
	5. sudo apt-get install build-essential openssl libreadline6 libreadline6-dev curl git-core zlib1g zlib1g-dev libssl-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt-dev autoconf libc6-dev ncurses-dev automake libtool bison subversion imagemagick graphicsmagick libmagickcore-dev libmagickwand-dev
	6. gem install therubyracer
	7. bundle install

### Dependency for wicked_pdf
	1. sudo apt-get install openssl build-essential xorg libssl-dev
	2. wget http://wkhtmltopdf.googlecode.com/files/wkhtmltopdf-0.9.9-static-amd64.tar.bz2
	3. tar xvjf wkhtmltopdf-0.9.9-static-amd64.tar.bz2
	4. sudo mv wkhtmltopdf-amd64 /usr/local/bin/wkhtmltopdf
	5. sudo chmod +x /usr/local/bin/wkhtmltopdf

### Dependency for Paperclip
    1.Check if imageprocessor ImageMagick is installed by typing "which convert" in your console. Might return something like "/usr/local...".
    If not install ImageMagick --> sudo apt-get install imagemagick
    2. sudo apt-get install libmagickwand-dev

bundle install
rake db:migrate
rake db:seed


### Configuration
	- Accounts extern:
		- GMAIL: companyportal99@gmail.com Passwort: cptest1234/
		- Dropbox: companyportal99@gmail.com Passwort: cptest1234/
		- PayPal - Verkäufer (www.sandbox.paypal.com): seller@cp.com Passwort: company-portal
		- PayPal - Käufer (www.sandbox.paypal.com): cpbuyer@cp.com Passwort: company-portal
	- Accounts intern:
		- Administrator (superadmin): superadmin@example.com
		- Customer (customer): customer@example.com
		- Vertrieb (sales): sales@example.com
		- Techniker (technician): technician@example.com
		- Buchhalter (accountant): accountant@example.com

		Passwörter sind überall: "testtest"

###Allgemeine Informationen:
	- Bei den seed Daten werden Bilder für Produkte etc. in die Dropbox hochgeladen und gespeichert, deswegen muss eine Internetverbindung vorhanden sein. Außerdem kann das Erstellen der Seeds etwas Zeit in Anspruch nehmen. (Verfügbarer Speicherplatz 2GB)

	- Rechnungen können nur auf Heroku über PayPal bezahlt werden, da PayPal keine IPN Notifications an "localhost:3000" senden kann. Wenn Sie doch über lokalen Server bezahlt werden, wird nicht es in den Applikation nicht als bezahlt erkannt.

	- Mailbenachrichtungen funktionieren nur bei Benutzern mit gültiger Emailaddresse (keine StandardAccounts aus den Seed Daten)

	-Mindmap wurde zu Beginn des Projektes erstellt, und weist nun einige Abweichnungen auf.

	- Vorgehen bei Businessprocesses:
		- Als Kunde einen Request anlegen
		- Als Sales Request Assume
		- Als Sales Offer erstellen (Request / Show)
		- Offer als Sales Assume
		- Mindestens 1 Position hinzufügen
		- Offer publishen
		- Als Kunde einloggen
		- Overview
		- Accept Offer
		- Als Sales Assignment assume
		- place order
		- position als arrived markieren
		- als Technician einloggen
		- Installation assume
		- close Installation
		- als Customer Rechnung bezahlen (Overview)