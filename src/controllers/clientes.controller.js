import { pool } from '../db.js';

// Obtener todos los clientes
export const obtenerClientes= async (req, res) => {
  try {
    const [result] = await pool.query('select * from Cliente');
    res.json(result);
  } catch (error) {
    return res.status(500).json({
      mensaje: 'Ha ocurrido un error al leer los datos de los clientes.',
      error: error
    });
  }
};

// Obtener un cliente por su ID
export const obtenerCliente = async (req, res) => {
  try {
    const [result] = await pool.query('SELECT * FROM Cliente WHERE ID_Cliente = ?', [req.params.id]);
    
    if (result.length <= 0) {
      return res.status(404).json({
        mensaje: `Error al leer los datos. El ID ${req.params.id} del cliente no fue encontrado.`
      });
    }
    res.json(result[0]);
  } catch (error) {
    return res.status(500).json({
      mensaje: 'Ha ocurrido un error al leer los datos del cliente.'
    });
  }
};


// Registrar un nuevo producto
export const registrarCliente = async (req, res) => {
  try {
    const { 
      Nombre, 
      Apellido, 
      ID_tipoCliente, 
    } = req.body;

    // Validación básica de campos requeridos
    if (!Nombre || !Apellido || !ID_tipoCliente ) {
      return res.status(400).json({
        mensaje: 'Faltan campos requeridos: nombreCliente, ApellidoCliente o tipoCliente .'
      });
    }

    const [result] = await pool.query(
      'INSERT INTO Cliente (Nombre, Apellido, ID_tipoCliente) VALUES (?, ?, ?)',
      [
        Nombre,
        Apellido,
        ID_tipoCliente
      ]
    );

    res.status(201).json({ 
      ID_Cliente: result.insertId,
      mensaje: 'Cliente registrado exitosamente'
    });
  } catch (error) {
    return res.status(500).json({
      mensaje: 'Ha ocurrido un error al registrar los clientes.',
      error: error.message
    });
  }
};

