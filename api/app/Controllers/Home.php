<?php

namespace App\Controllers;

use CodeIgniter\Controller;

class Home extends BaseController
{
    protected $db;

    public function index(): string
    {
        return view('welcome_message');
    } 

    public function ejemplos()
    {
        $this->db = \Config\Database::connect();

        // Consulta 1:
        $query_pedidosCliente = $this->db->query(
            "SELECT p.id_pedido, c.nombre, c.apellido, p.fecha_pedido, p.total, p.estado, p.productos
            FROM pedidos p
            JOIN clientes c ON p.id_cliente = c.id_cliente
            WHERE c.email = 'juan.perez@example.com'"
        );

        $pedidosCliente = $query_pedidosCliente->getResultArray();

        // Consulta 2:
        $query_totalPedidosEstado = $this->db->query(
            'SELECT estado, COUNT(*) AS total_pedidos, SUM(total) AS total_ventas
            FROM pedidos
            GROUP BY estado
            ORDER BY total_ventas DESC'
        );

        $totalPedidosEstado = $query_totalPedidosEstado->getResultArray();

        // Consulta 3:
        $query_clientesSuperiores = $this->db->query(
            'SELECT DISTINCT c.id_cliente, c.nombre, c.apellido, SUM(p.total) AS total_gastado
            FROM clientes c
            JOIN pedidos p ON c.id_cliente = p.id_cliente
            GROUP BY c.id_cliente, c.nombre, c.apellido
            HAVING SUM(p.total) > 100
            ORDER BY total_gastado DESC'
        );

        $clientesSuperiores = $query_clientesSuperiores->getResultArray();

        return $this->response->setJSON([
            'pedidosCliente' => $pedidosCliente,
            'totalPedidosEstado' => $totalPedidosEstado,
            'clientesSuperiores' => $clientesSuperiores
        ]);
    }
}
