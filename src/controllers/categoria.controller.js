import { pool } from '../db.js';

// Obtener todos llas categorias
export const obtenerCategoria= async (req, res) => {
  try {
    const [result] = await pool.query('select * from Categorias');
    res.json(result);
  } catch (error) {
    return res.status(500).json({
      mensaje: 'Ha ocurrido un error al leer los datos de las categorias.',
      error: error
    });
  }
};

// Obtener una categoria por su ID
export const obtenerCategoriaid = async (req, res) => {
    try {
      const [result] = await pool.query('SELECT * FROM Categorias WHERE  ID_Categoria = ?', [req.params.id]);
      
      if (result.length <= 0) {
        return res.status(404).json({
          mensaje: `Error al leer los datos. El ID ${req.params.id} del categoria no fue encontrado.`
        });
      }
      res.json(result[0]);
    } catch (error) {
      return res.status(500).json({
        mensaje: 'Ha ocurrido un error al leer los datos del cliente.'
      });
    }
  };

    // Registrar una nueva categoría
export const registrarCategoria = async (req, res) => {
  try {
    const {  NombreCategoria } = req.body;

    const [result] = await pool.query(
      'INSERT INTO Categorias ( NombreCategoria) VALUES (?)',
      [ NombreCategoria]
    );

    res.status(201).json({ ID_Categoria: result.insertId });
  } catch (error) {
    return res.status(500).json({
      mensaje: 'Ha ocurrido un error al registrar la categoría.',
      error: error
    });
  }
};

export const eliminarCategoria = async (req, res) => {
  try {
    const [result] = await pool.query('DELETE FROM Categorias WHERE ID_Categoria = ?', [req.params.id]);

    if (result.affectedRows === 0) {
      return res.status(404).json({
        mensaje: `Error al eliminar la categoría. El ID ${req.params.id} no fue encontrado.`
      });
    }

    res.status(204).send(); // Respuesta sin contenido para indicar éxito
  } catch (error) {
    return res.status(500).json({
      mensaje: 'Ha ocurrido un error al eliminar la categoría.',
      error: error
    });
  }
};

export const actualizarCategoria = async (req, res) => {
  try {
    const { id } = req.params;
    const datos = req.body;

    const [resultado] = await pool.query(
      'UPDATE Categorias SET ? WHERE ID_Categoria = ?',
      [datos, id]
    );

    if (resultado.affectedRows === 0) {
      return res.status(404).json({
        mensaje: `La categoría con ID ${id} no existe.`,
      });
    }

    res.status(204).send(); // Respuesta sin contenido para indicar éxito
  } catch (error) {
    return res.status(500).json({
      mensaje: 'Error al actualizar la categoría.',
      error: error,
    });
  }
};



  
