# ED-FI-X-ASPIRE-NOTIFICATIONS

A stand-alone text messaging solution sits alongside the ed-fi ods and uses custom tables, custom views and database procedures to schedule text messaging notifications to students. Once this solution is deployed the code can be customized to cater to your specific needs. 

This project uses a third-party plug-in from CDATA to interface with the text messaging provider such as Twilio.
## Database Deployment Instructions

**Note** The following deployment is for the Ed-Fi ODS Database hosted in Microsoft Azure and the scripts processed in Microsoft SQL Server Management Studio (SSMS). If the Ed-Fi ODS is hosted on another platform, the scripts may need to be run individually and/or adjusted for that platform.
###	Objects Set up In Database
1. Download the Deployment Scripts.zip and extract to a directory (recommended C:\Scripts).
2. Launch SSMS and connect to the Ed-Fi ODS Database
3. Open the CREATE_ATTENDANCE_ABSENTEE_OBJECTS.sql file
4. With the script file opened, go to the “Query” Menu and Select “SQLCMD mode”

5. If the Scripts are extracted to a different location than the default (C:\Scripts\), update the path in the following line (replacing “C:\Scripts\” with your scripts directory).
:SETVAR ScriptDir “C:\Scripts\”
6. Execute the Script
    - It will create 2 schemas (attendance and absentee) if not already in the database
    - It will call a series of sql scripts to create the tables, views, functions and stored procedures.
        - The primary tables used by the Messaging System are absentee.NotificationPendingQueue and absentee.NotificationSentLog. Other tables are for generating the chronic absentee data in order to create the messages needed to be sent. These can be adjusted to individual organization needs.
        ii. The views are also used for generating the chronic absentee data related to individual message template. These can be adjusted to individual organization needs.
        iii. Similarly, the stored procedures are also primarily used for generating the chronic absentee data. These can be adjusted to individual organization needs.

###	Sample Data Setup
1. To use sample set up data (i.e. sample chronic absences text message templates), open the CREATE SAMPLE SETUP DATA.sql script file in SSMS and Execute the script.
    a. The script will create some basic data like the message frequency, contact type, the text messages templates, the variables used in these templates, etc. These can be adjusted to individual organization needs.

###	Generate the Chronic Absentee Data and Text Messages to be sent
1. In SSMS, select the database which the objects were created, run the following:
EXEC absentee.sproc_PrepareData
The messages to be sent will be created in the absentee.NotificationPendingQueue table. Refer to the Notification System Documentation for the Messaging Component.

###	Reset the Database Objects
1. This will remove all the tables, views, functions and stored procedures created in Section I above. However, it will not drop the 2 created schemas. To drop the schemas, simply issue a DROP SCHEMA statement after all the objects are dropped.
2. In SSMS, select the database which the objects were created, run the following:
EXEC RESET_ATTENDANCE_ABSENTEE_OBJECTS.sql

## Twilio (for Text Messaging) Deployment Instructions:
**Notes** 
* Messages are to be sent via Twilio. For different providers, use the following as guidance but adapt to your provider.
* The following deployment is for using an ODBC driver connecting to Twilio, with the license acquired from CData (https://www.cdata.com/). With the ODBC driver, simple SQL statements can be written to insert text messages to Twilio’s database table and the text messages will be sent automatically. If the text messaging platform is different, or if not using the ODBC driver, the steps will need to be modified to get the text messages sent out.
* The ODBC connection is set up on a local SQL Server, retrieving the messages to be sent from the Ed-Fi ODS database and inserting them into the Twilio database. Both the Ed-Fi ODS and the Twilio ODBC are set up as Linked Servers in the local SQL Server.
* Download the Deployment Scripts Local SQL.zip and extract to a directory.

###	Setting up the Linked Server for Ed-Fi ODS
1.	Launch SSMS and connect to the a local SQL Server
2.	Open the Setup_Linked_Server_For_ODS_Azure_Server.sql script and modify the connection info for the Server, Username and password. Execute the script. This will create the linked server to the Ed-Fi ODS Server’s database.
###	Setting up the Linked Server for Twilio
1.	Purchase and download the CData ODBC driver (https://www.cdata.com/drivers/twilio/) 30-day trial is available.
2.	Follow instructions from CData to set up the ODBC driver on the server where the local SQL Database is stored.
2.	Launch SSMS and connect to the a local SQL Server
3.	Open the Setup_Linked_Server_For_Twilio_ODBC.sql script and modify the connection info for the Catalog (the ODBC name), Username and password. Execute the script. This will create the linked server to the Twilio database.
###	Creating and Execute the Stored Procedures for Sending Text Messages
1.	In SSMS, select a local database for the stored procedure to be created.
2.	Open the CreateSproc_absentee_send_notifications.sql.sql file. Update the value for the @FromPhoneNumber variable to the phone number associated with the Twilio account
3.	The script creates a stored procedure in the absentee schema. Make sure the schema already exists in the database (feel free to change the schema name if needed).
4.	Update the reference name to the linked servers if necessary to match your instances.
5.	Execute the Script to create the stored procedure
6.	Run the following to send out the notifications via Twilio
	EXEC absentee.sproc_SendNotifications
7.	Pending messages that have been will be deleted from the Pending messages table (absentee.NotificationPendingQueue) in the Ed-Fi ODS database. Corresponding records will be inserted into a log table (absentee.NotificationSentLog) in the Ed-Fi ODS database.


## Legal Information

Copyright (c) 2021 Ed-Fi Alliance, LLC and contributors.

Licensed under the [Apache License, Version 2.0](LICENSE) (the "License").

Unless required by applicable law or agreed to in writing, software distributed
under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
CONDITIONS OF ANY KIND, either express or implied. See the License for the
specific language governing permissions and limitations under the License.

See [NOTICES](NOTICES.md) for additional copyright and license notifications.