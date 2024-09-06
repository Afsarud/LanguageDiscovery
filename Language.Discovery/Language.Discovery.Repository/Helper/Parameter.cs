using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using System.Threading.Tasks;

namespace Language.Discovery.Repository
{
    public class Parameter
    {

        string m_name;
        object m_value;
        System.Data.ParameterDirection m_direction = ParameterDirection.Input;
        System.Data.DbType m_dbType;

        public Parameter()
        {

        }
        public Parameter(string _name, object _value)
        {
            m_name = _name;
            m_value = _value;
        }
        public Parameter(string _name, object _value, System.Data.ParameterDirection _direction)
        {
            m_name = _name;
            m_value = _value;
            m_direction = _direction;
        }

        public Parameter(string _name, object _value, System.Data.DbType dbtype, System.Data.ParameterDirection _direction)
        {
            m_name = _name;
            m_value = _value;
            m_direction = _direction;
            m_dbType = dbtype;
        }

        public string Name
        {
            get { return m_name; }
            set { m_name = value; }
        }

        public object Value
        {
            get { return m_value; }
            set { m_value = value; }
        }

        public System.Data.ParameterDirection Direction
        {
            get { return m_direction; }
            set { m_direction = value; }
        }

        public System.Data.DbType DataType
        {
            get { return m_dbType; }
            set { m_dbType = value; }
        }

    }
}
