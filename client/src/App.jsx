import { useState, useEffect } from 'react'

function App() {
    const [data, setData] = useState(null);

    useEffect(() => {
        const apiUrl = import.meta.env.VITE_API_URL || '';
        fetch(`${apiUrl}/api/health`)
            .then(res => res.json())
            .then(data => setData(data))
            .catch(err => console.error('Error fetching health check:', err));
    }, []);

    return (
        <div className="container">
            <h1>SHOPSMART TERMINAL v1.0</h1>
            <div className="card">
                <h2>system_status</h2>
                {data ? (
                    <div>
                        <p>╔════════════════════════════════╗</p>
                        <p>║ Developer: Antik               ║</p>
                        <p>║ Status: [{data.status}]             ║</p>
                        <p>║ Message: {data.message.padEnd(18)}║</p>
                        <p>║ Time: {new Date(data.timestamp).toLocaleTimeString().padEnd(22)}║</p>
                        <p>╚════════════════════════════════╝</p>
                    </div>
                ) : (
                    <p>[ LOADING... ]</p>
                )}
            </div>
            <p className="hint">
                // Edit src/App.jsx to modify interface
            </p>
        </div>
    )
}

export default App
