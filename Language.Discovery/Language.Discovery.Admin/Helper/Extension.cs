using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Language.Discovery.Admin
{
    public static class Extension
    {
        public static IEnumerable<string> SplitByLength(this string str, int maxLength)
        {
            int index = 0;
            while (index + maxLength < str.Length)
            {
                yield return str.Substring(index, maxLength);
                index += maxLength;
            }

            yield return str.Substring(index);
        }
    }
}