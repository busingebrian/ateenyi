from flask import Flask, request, jsonify
from flask_sqlalchemy import SQLAlchemy
from datetime import datetime

# Initialize Flask app and database
app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///salon.db'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

db = SQLAlchemy(app)

# Define database models
class Customer(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(100), nullable=False)
    phone = db.Column(db.String(15), nullable=True)
    email = db.Column(db.String(100), nullable=True)

class Service(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(100), nullable=False)
    price = db.Column(db.Float, nullable=False)
    duration_minutes = db.Column(db.Integer, nullable=False)

class Appointment(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    customer_id = db.Column(db.Integer, db.ForeignKey('customer.id'), nullable=False)
    service_id = db.Column(db.Integer, db.ForeignKey('service.id'), nullable=False)
    appointment_time = db.Column(db.DateTime, nullable=False)
    status = db.Column(db.String(50), default='Scheduled')  # Scheduled, Completed, Cancelled

    customer = db.relationship('Customer', backref='appointments')
    service = db.relationship('Service', backref='appointments')

# Routes
@app.route('/add_customer', methods=['POST'])
def add_customer():
    data = request.json
    new_customer = Customer(name=data['name'], phone=data.get('phone'), email=data.get('email'))
    db.session.add(new_customer)
    db.session.commit()
    return jsonify({'message': 'Customer added successfully!', 'customer_id': new_customer.id}), 201

@app.route('/add_service', methods=['POST'])
def add_service():
    data = request.json
    new_service = Service(name=data['name'], price=data['price'], duration_minutes=data['duration_minutes'])
    db.session.add(new_service)
    db.session.commit()
    return jsonify({'message': 'Service added successfully!', 'service_id': new_service.id}), 201

@app.route('/book_appointment', methods=['POST'])
def book_appointment():
    data = request.json
    appointment_time = datetime.strptime(data['appointment_time'], '%Y-%m-%d %H:%M:%S')
    new_appointment = Appointment(
        customer_id=data['customer_id'],
        service_id=data['service_id'],
        appointment_time=appointment_time
    )
    db.session.add(new_appointment)
    db.session.commit()
    return jsonify({'message': 'Appointment booked successfully!', 'appointment_id': new_appointment.id}), 201

@app.route('/list_appointments', methods=['GET'])
def list_appointments():
    appointments = Appointment.query.all()
    output = [
        {
            'id': appointment.id,
            'customer': appointment.customer.name,
            'service': appointment.service.name,
            'appointment_time': appointment.appointment_time.strftime('%Y-%m-%d %H:%M:%S'),
            'status': appointment.status
        } for appointment in appointments
    ]
    return jsonify(output), 200

@app.route('/update_appointment_status/<int:appointment_id>', methods=['PUT'])
def update_appointment_status(appointment_id):
    data = request.json
    appointment = Appointment.query.get(appointment_id)
    if not appointment:
        return jsonify({'message': 'Appointment not found!'}), 404

    appointment.status = data['status']
    db.session.commit()
    return jsonify({'message': 'Appointment status updated successfully!'}), 200

@app.route('/list_services', methods=['GET'])
def list_services():
    services = Service.query.all()
    output = [
        {
            'id': service.id,
            'name': service.name,
            'price': service.price,
            'duration_minutes': service.duration_minutes
        } for service in services
    ]
    return jsonify(output), 200

if __name__ == '__main__':
    with app.app_context():
        db.create_all()  # Create tables
    app.run(debug=True)