Project Requirements
--

## The project consisted of designing and implementing a relational database system for TechServicesCR, an internal technical support company. The database needed to:

Register and track service requests created by employees when reporting issues with their equipment.

Store user information (ID, name, department, phone, email).

Manage service orders (ID, description, creation date, status: Pending, In Process, Completed, completion date, assigned technician).

Include technician details (ID, name, specialty, phone, email).

Maintain equipment inventory (ID, type, location, serial number).

Record order history (updates, actions taken, observations, technician responsible).

## Key Requirements

Normalization up to Third Normal Form (3NF).

Clear entity-relationship diagram (Crow’s Foot notation) with correct cardinalities.

Implementation of referential integrity using primary and foreign keys.

Ability to generate reports by request status, view technicians involved in each case, and review the full order history sorted by date.

Deliverables included: ERD diagram, normalization explanation, SQL creation script (MySQL Workbench), and documentation.
