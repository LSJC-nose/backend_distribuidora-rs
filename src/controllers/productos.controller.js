import { pool } from '../db.js';

// Obtener todos los productos
export const obtenerProductos = async (req, res) => {
  try {
    const [result] = await pool.query('SELECT * FROM Producto');
    res.json(result);
  } catch (error) {
    return res.status(500).json({
      mensaje: 'Ha ocurrido un error al leer los datos de los productos.',
      error: error
    });
  }
};

// Obtener un producto por su ID
export const obtenerProducto = async (req, res) => {
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
    const { Stock, ID_Categoria, PrecioCompra, PrecioVenta, nombreProducto, Descripcion, UbicacionFotografia, ID_catalogo } = req.body;

    // Validación básica
    if (!Stock || !ID_Categoria || !PrecioCompra || !PrecioVenta || !nombreProducto || !Descripcion || !UbicacionFotografia || !ID_catalogo) {
      return res.status(400).json({ mensaje: "Todos los campos son obligatorios." });
    }

    const [result] = await pool.query(
      'INSERT INTO Producto (Stock, ID_Categoria, PrecioCompra, PrecioVenta, nombreProducto, Descripcion, UbicacionFotografia, ID_catalogo) VALUES (?, ?, ?, ?, ?, ?, ?, ?)',
      [Stock, ID_Categoria, PrecioCompra, PrecioVenta, nombreProducto, Descripcion, UbicacionFotografia, ID_catalogo]
    );

    res.json({ mensaje: "Producto registrado correctamente", ID_Producto: result.insertId });
  } catch (error) {
    return res.status(500).json({ mensaje: "Ha ocurrido un error al registrar el producto.", error });
  }
};

// Actualizar un producto por su ID
export const actualizarProducto = async (req, res) => {
  try {
    const { Stock, ID_Categoria, PrecioCompra, PrecioVenta, nombreProducto, Descripcion, UbicacionFotografia, ID_catalogo } = req.body;
    const { id } = req.params;

    const [result] = await pool.query(
      'UPDATE Producto SET Stock = ?, ID_Categoria = ?, PrecioCompra = ?, PrecioVenta = ?, nombreProducto = ?, Descripcion = ?, UbicacionFotografia = ?, ID_catalogo = ? WHERE ID_Producto = ?',
      [Stock, ID_Categoria, PrecioCompra, PrecioVenta, nombreProducto, Descripcion, UbicacionFotografia, ID_catalogo, id]
    );

    if (result.affectedRows === 0) {
      return res.status(404).json({ mensaje: `Error al actualizar. El producto con ID ${id} no fue encontrado.` });
    }

    res.json({ mensaje: "Producto actualizado correctamente" });
  } catch (error) {
    return res.status(500).json({ mensaje: "Ha ocurrido un error al actualizar el producto.", error });
  }
};

// Eliminar un producto por su ID
export const eliminarProducto = async (req, res) => {
  try {
    const { id } = req.params;

    const [result] = await pool.query('DELETE FROM Producto WHERE ID_Producto = ?', [id]);

    if (result.affectedRows === 0) {
      return res.status(404).json({ mensaje: `Error al eliminar. El producto con ID ${id} no fue encontrado.` });
    }

    res.json({ mensaje: "Producto eliminado correctamente" });
  } catch (error) {
    return res.status(500).json({ mensaje: "Ha ocurrido un error al eliminar el producto.", error });
  }
};
