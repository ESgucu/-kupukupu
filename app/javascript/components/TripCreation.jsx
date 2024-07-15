import React, { useState } from 'react';
import './stylesheets/TripCreation.css';

const TripCreation = () => {
    const [formData, setFormData] = useState({
        tripName: '',
        yourName: '',
        departure: '',
        travelDate: '',
        returnDate: ''
    });

    const handleChange = (e) => {
        const { name, value } = e.target;
        setFormData(prevState => ({
            ...prevState,
            [name]: value
        }));
    };

    const handleSubmit = (e) => {
        e.preventDefault();
        // Handle form submission logic
    };

    return (
        <form onSubmit={handleSubmit}>
            <div>
                <h2>Trip Creation</h2>
                <label>Trip Name</label>
                <input type="text" name="tripName" value={formData.tripName} onChange={handleChange} />

                <label>Your Name</label>
                <input type="text" name="yourName" value={formData.yourName} onChange={handleChange} />

                <label>Departure</label>
                <input type="text" name="departure" value={formData.departure} onChange={handleChange} />

                <label>Travel Date</label>
                <input type="date" name="travelDate" value={formData.travelDate} onChange={handleChange} />

                <label>Return Date</label>
                <input type="date" name="returnDate" value={formData.returnDate} onChange={handleChange} />

                <button type="button">Add more travelers</button>
                <button type="submit">Find Destinations</button>
            </div>

            <div>
                <h3>Cheapest Destinations</h3>
                <div>Destination 1</div>
                <div>Destination 2</div>
                <div>Destination 3</div>
                <div>Destination 4</div>
            </div>

            <div>
                <button type="button">Team up to choose the destination</button>
            </div>

            <div>
                <h3>Welcome XX</h3>
                <p>Click on the destinations you would like to go</p>
                <div>Destination 1 - $300</div>
                <div>Destination 2 - $450</div>
                <div>Destination 3 - $500</div>
                <div>Destination 4 - $600</div>
            </div>
        </form>
    );
};

export default TripCreation;
