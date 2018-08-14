using System;
using System.Diagnostics;
using System.Net.Http;
using System.Threading.Tasks;
using Plugin.Connectivity;

namespace RndBook.Services.Network
{
    public class BackendClient : IBackendClient
    {
        HttpClient _client;

        public BackendClient(string backendUrl)
        {
            _client = new HttpClient
            {
                BaseAddress = new Uri($"{backendUrl}/")
            };
        }

        public async Task<IBackendResponse> GetAsync(string url)
        {
            if (!CrossConnectivity.Current.IsConnected)
                return BackendResponse.FromError("No connection");

            try
            {
                var responseData = await _client.GetStringAsync(url);
                if (string.IsNullOrEmpty(responseData))
                    return BackendResponse.FromError("Empty response");

                return BackendResponse.WithData(responseData);
            }
            catch (Exception e)
            {
                Debug.WriteLine(e.Message);
                return BackendResponse.FromError(e.Message);
            }

        }
    }
}
