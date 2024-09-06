using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;
using System.Xml;
using System.Xml.Serialization;

namespace Language.Discovery.Entity
{
    public class Utility
    {
        public static string SerializeObjectToXML(object item)
        {
            try
            {
                
                string xmlText;
                Type objectType = item.GetType();
                XmlSerializer xmlSerializer = new XmlSerializer(objectType);
                MemoryStream memoryStream = new MemoryStream();
                using (XmlTextWriter xmlTextWriter =
                    new XmlTextWriter(memoryStream, Encoding.UTF8) { Formatting = Formatting.Indented })
                {
                    xmlSerializer.Serialize(xmlTextWriter, item);
                    memoryStream = (MemoryStream)xmlTextWriter.BaseStream;
                    xmlText = new UTF8Encoding().GetString(memoryStream.ToArray());
                    memoryStream.Dispose();
                    xmlTextWriter.Flush();
                    xmlText = xmlText.Replace("<?xml version=\"1.0\" encoding=\"utf-8\"?>", string.Empty);
                    return xmlText;
                }
            }
            catch (Exception e)
            {
                System.Diagnostics.Debug.Write(e.ToString());
                return null;
            }
        }

        public static object DeserializeXMLToObject(string xmlText, Type objectType)
        {
            if (string.IsNullOrEmpty(xmlText)) return null;
            XmlSerializer xs = new XmlSerializer(objectType);
            using (MemoryStream memoryStream = new MemoryStream(new UTF8Encoding().GetBytes(xmlText)))
            {
                return xs.Deserialize(memoryStream);
            }
        }
    }
}
