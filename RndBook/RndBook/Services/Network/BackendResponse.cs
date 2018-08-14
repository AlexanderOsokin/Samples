using System;
namespace RndBook.Services.Network
{
    public class BackendResponse : IBackendResponse
    {
        public bool IsSuccess { get; set; }
        public string ErrorDescription { get; set; }
        public string Data { get; set; }

        public static BackendResponse Empty =>
            new BackendResponse()
            {
                IsSuccess = false,
                ErrorDescription = string.Empty,
                Data = string.Empty
            };

        public static BackendResponse FromError(string err)
        {
            return new BackendResponse()
            {
                IsSuccess = false,
                ErrorDescription = err,
                Data = string.Empty
            };
        }

        public static BackendResponse WithData(string data)
        {
            return new BackendResponse()
            {
                IsSuccess = true,
                ErrorDescription = string.Empty,
                Data = data
            };
        }
    }
}
