Arbeit 2014 :: 67-327
===
This is an insecure version of the Arbeit project for 67-327: Web Application Security.  Arbeit was originally conceived as an excuse to play around with the awesome Chronic gem and requires this gem to run.  The Arbeit project is used in 67-272 to demonstrate some more advanced features in Rails, introduces multi-model forms, and uses some jQuery.  This version of the system is different in noticeable ways (some new features, some changes to the database, some unusual coding) so that the end result is that it is more insecure than the original project. (Not that we really focused on securing the app in 67-272...)  Students in 67-327 will be finding ways to exploit this application and recording their discoveries.

It does have its own populate file, so after migrating the database, you can simply run 'rake db:populate' to add fake (but somewhat realistic) data.  If you want to log in as an admin, use my email (profh@cmu.edu) along with one of the passwords found in the 12_common_passwords.txt (see course site for that list).  The password is randomly generated from that list, so which one works for each student is hard to say.  The populate task will also migrate the database, so if you hose the database somehow, you can simply drop it ('rake db:drop') and then rerun 'rake db:populate' to rebuild it and repopulate it.

Of course, part of the challenge is not telling you exactly where the vulnerabilities are or even how many there are, but if it is at all helpful, there are at least a dozen (very likely more) vulnerabilities for you to uncover.  You can use any tool you like: Burp Suite, Tamper Data, sqlmap, Firebug and the like.  Of course, be careful not to overlook the obvious and the low-hanging fruit in search of only on the most difficult exploits.  (There are both easy and hard exploits in this application waiting to be discovered.)

PDF or MS Word copies of the summary lab assignment and the reporting template can be found in the doc/ directory of this project.

Qapla'

Prof. H