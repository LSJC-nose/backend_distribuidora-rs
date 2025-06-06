import { pool } from '../db.js';

// Obtener todos los productos
export const obtenerProductos = async (req, res) => {
  try {
    const [result] = await pool.query(`SELECT ID_Producto,
      p.nombreProducto,
      p.Stock, 
      c.NombreCategoria,
      p.PrecioCompra,
      p.PrecioVenta,
      p.Descripcion,
      p.UbicacionFotografia
      FROM categorias c 
      INNER JOIN Producto p ON c.ID_Categoria = p.ID_Categoria`
      
    );
    res.json(result);
  } catch (error) {
    return res.status(500).json({
      mensaje: 'Ha ocurrido un error al leer los datos de los productos.',
      error: error
    });
  }
};

// Obtener un producto por su ID
export const obtenerProductoId = async (req, res) => {
  try {
    const [result] = await pool.query('SELECT * FROM Producto WHERE ID_Producto = ?', [req.params.id]);

    if (result.length <= 0) {
      return res.status(404).json({
        mensaje: `Error al leer los datos. El ID ${req.params.id} del producto no fue encontrado.`
      });
    }
    res.json(result[0]);
  } catch (error) {
    return res.status(500).json({
      mensaje: 'Ha ocurrido un error al leer los datos del producto.'
    });
  }
};

// Registrar un nuevo producto
export const registrarProducto = async (req, res) => {
  try {
    const { Stock, 
      ID_Categoria, 
      PrecioCompra, 
      PrecioVenta,
      nombreProducto, 
      Descripcion, 
      UbicacionFotografia,
      ID_catalogo 
      } = req.body;

    if (!Stock || !ID_Categoria || !PrecioCompra || !PrecioVenta || !nombreProducto  ) {
      return res.status(400).json({ mensaje: 'Todos los campos son obligatorios.' });
    }

    const [result] = await pool.query(
      'INSERT INTO Producto (Stock, ID_Categoria, PrecioCompra, PrecioVenta, nombreProducto, Descripcion, UbicacionFotografia, ID_catalogo) VALUES (?, ?, ?, ?, ?, ?, ?,?)',
      [Stock, 
        ID_Categoria,
         PrecioCompra, 
         PrecioVenta, 
         nombreProducto, 
         Descripcion || null, 
         UbicacionFotografia || null, 
         ID_catalogo] 
    );

    res.status(201).json({ ID_Producto: result.insertId, mensaje: 'Producto registrado exitosamente' });
  } catch (error) {
    return res.status(500).json({
      mensaje: 'Ha ocurrido un error al registrar el producto.',
      error: error.message
    });
  }
};

// Actualizar un producto por su ID
export const actualizarProductos = async (req, res) => {
  try {
    const { id } = req.params;
    const datos = req.body;

    const [resultado] = await pool.query('UPDATE Producto SET ? WHERE ID_Producto = ?', [datos, id]);

    if (resultado.affectedRows === 0) {
      return res.status(404).json({ mensaje: `El producto con ID ${id} no existe.` });
    }

    res.status(200).json({ mensaje: 'Producto actualizado exitosamente' });
  } catch (error) {
    return res.status(500).json({ mensaje: 'Error al actualizar el producto.', error: error.message });
  }
};

// Eliminar un producto por su ID
export const eliminarProducto = async (req, res) => {
  try {
    const { id } = req.params;

    const [resultado] = await pool.query('DELETE FROM Producto WHERE ID_Producto = ?', [id]);

    if (resultado.affectedRows === 0) {
      return res.status(404).json({ mensaje: `No se encontró el producto con ID ${id}.` });
    }

    res.status(204).send();
  } catch (error) {
    return res.status(500).json({ mensaje: 'Error al eliminar el producto.', error: error.message });
  }
};
