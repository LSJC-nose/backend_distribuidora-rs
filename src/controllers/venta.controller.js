import { pool } from '../db.js';

// Obtener todas las ventas con sus detalles, mostrando nombres, IDs y subtotal
export const obtenerVentasConDetalles = async (req, res) => {
  try {
    const [result] = await pool.query(`
     SELECT
    v.ID_Venta,
    dv.ID_Detalle,
    v.ID_Tiempo,
     c.Nombre As nombreCliente,
    p.nombreProducto,
    dv.Cantidad,
    dv.PrecioVenta,
    (dv.Cantidad * dv.PrecioVenta) AS subtotal
FROM
    Venta_factura v
INNER JOIN
    Cliente c ON v.ID_Cliente = c.ID_Cliente -- Corrección: relacionar por ID_Cliente
INNER JOIN
    Detalle_venta_factura dv ON v.ID_Venta = dv.ID_Venta
INNER JOIN
    Producto p ON dv.ID_Producto = p.ID_Producto;

    `);
    
    res.json(result);
  } catch (error) {
    return res.status(500).json({
      mensaje: 'Ha ocurrido un error al leer los datos de las ventas.',
      error: error
    });
  }
};


// Registrar una nueva categoría
export const registrarCategoria = async (req, res) => {
  try {
    const { nombre_categoria, descripcion_categoria } = req.body;

    const [result] = await pool.query(
      'INSERT INTO categorias (nombre_categoria, descripcion_categoria) VALUES (?, ?)',
      [nombre_categoria, descripcion_categoria]
    );

    res.status(201).json({ id_categoria: result.insertId });
  } catch (error) {
    return res.status(500).json({
      mensaje: 'Ha ocurrido un error al registrar la categoría.',
      error: error
    });
  }
};



