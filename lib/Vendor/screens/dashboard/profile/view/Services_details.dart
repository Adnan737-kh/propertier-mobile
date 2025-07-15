import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propertier/Vendor/screens/dashboard/profile/model/service_model.dart';
import 'package:propertier/extensions/localization_extension.dart';
import 'package:video_player/video_player.dart';

class ServiceAdsDetailScreen extends StatefulWidget {
  final ServiceModel service;

  const ServiceAdsDetailScreen({super.key, required this.service});

  @override
  State<ServiceAdsDetailScreen> createState() => _ServiceAdsDetailScreenState();
}

class _ServiceAdsDetailScreenState extends State<ServiceAdsDetailScreen> {
  VideoPlayerController? _controller;
  bool _isPlaying = false;
  String? selectedImagePath;

  @override
  void initState() {
    super.initState();
    _initVideoPlayer();
  }

  void _initVideoPlayer() {
    final shortVideoUrl = widget.service.shortVideoUrl;
    if (shortVideoUrl != null && shortVideoUrl.isNotEmpty) {
      _controller = VideoPlayerController.network(shortVideoUrl)
        ..initialize().then((_) {
          setState(() {});
          _controller?.play();
        });
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  void _playPauseVideo() {
    setState(() {
      if (_controller!.value.isPlaying) {
        _controller!.pause();
      } else {
        _controller!.play();
      }
      _isPlaying = _controller!.value.isPlaying;
    });
  }

  @override
  Widget build(BuildContext context) {
    final service = widget.service;
    final serviceTitle = service.title;
    final coverImageUrl = service.service!.coverImageUrl ?? '';
    final description = service.service!.description ?? 'No Description';
    final createdAt = service.createdAt;
    final elapsedTime = getElapsedTime(createdAt!);

    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                width: Get.size.width,
                height: Get.height * .28,
                decoration: const ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                  ),
                  shadows: [
                    BoxShadow(
                      color: Color(0x19000000),
                      blurRadius: 10,
                      offset: Offset(0, 1),
                      spreadRadius: 0,
                    )
                  ],
                ),
                child: selectedImagePath != null
                    ? ClipRRect(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(14),
                          bottomRight: Radius.circular(14),
                        ),
                        child: Image.network(
                          selectedImagePath!,
                          fit: BoxFit.cover,
                        ),
                      )
                    : ClipRRect(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(14),
                          bottomRight: Radius.circular(14),
                        ),
                        child: Image.network(
                          selectedImagePath ?? coverImageUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              'assets/icons/placeholder.png', // Path to your placeholder image
                              fit: BoxFit.cover,
                            );
                          },
                        ),
                      ),
              ),
              Positioned(
                top: 32,
                left: 14,
                right: 8,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.share,
                        size: 34,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 12,
                left: 2,
                right: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: Get.height * .066,
                      child: ListView.builder(
                        itemCount: service.imageUrls?.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          final imageUrl = service.imageUrls?[index];
                          bool hasValidImageUrl = imageUrl!.isNotEmpty &&
                              Uri.tryParse(imageUrl)?.isAbsolute == true;

                          return InkWell(
                            onTap: () {
                              setState(() {
                                selectedImagePath = imageUrl;
                              });
                            },
                            child: Container(
                              width: Get.width * .13,
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              decoration: ShapeDecoration(
                                color: Colors.grey
                                    .shade300, // Background color for placeholder
                                shape: RoundedRectangleBorder(
                                  side: const BorderSide(
                                      width: 1, color: Colors.white),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                              child: hasValidImageUrl
                                  ? FadeInImage.assetNetwork(
                                      placeholder:
                                          'assets/icons/placeholder.png', // Local placeholder image
                                      image: imageUrl,
                                      fit: BoxFit.cover,
                                      imageErrorBuilder:
                                          (context, error, stackTrace) {
                                        // Return the placeholder if the image fails to load
                                        return Image.asset(
                                          'assets/icons/placeholder.png',
                                          fit: BoxFit.cover,
                                        );
                                      },
                                    )
                                  : Image.asset(
                                      'assets/icons/placeholder.png', // Default placeholder
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 14,
          ),
          SizedBox(
            height: Get.height * .7,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(7),
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        shadows: const [
                          BoxShadow(
                            color: Color(0x19000000),
                            blurRadius: 10,
                            offset: Offset(1, 1),
                            spreadRadius: 0,
                          )
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                child: Text(
                                  serviceTitle!,
                                  style: const TextStyle(
                                    color: Color(0xFF131A22),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 5),
                              Text(
                                elapsedTime,
                                style: const TextStyle(
                                  color: Color(0xCC131A22),
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 9),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.location_pin,
                                color: Colors.amber,
                                size: 18,
                              ),
                              SizedBox(width: 3),
                              Text(
                                'Lorem ipsum dolor sit amet', // Adjust to actual location if available
                                style: TextStyle(
                                  color: Color(0xCC131A22),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 2),
                          const Divider(),
                          const SizedBox(height: 2),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                context.local.description,
                                style: const TextStyle(
                                  color: Color(0xB2131A22),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            description,
                            style: const TextStyle(
                              color: Color(0xCC131A22),
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 22,
                    ),
                    const Text(
                      'Short Tour',
                      style: TextStyle(
                        color: Color(0xFF131A22),
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Colors.grey.shade300,
                      ),
                      child: Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: _controller?.value.isInitialized ?? false
                              ? Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    AspectRatio(
                                      aspectRatio:
                                          _controller!.value.aspectRatio,
                                      child: VideoPlayer(_controller!),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        _playPauseVideo();
                                      },
                                      child: Container(
                                        height: 44,
                                        width: 44,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white,
                                        ),
                                        child: Icon(
                                          _isPlaying
                                              ? Icons.pause
                                              : Icons.play_arrow,
                                          size: 36,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : const Center(
                                  child: CircularProgressIndicator(),
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String getElapsedTime(DateTime createdAt) {
    final now = DateTime.now();
    final duration = now.difference(createdAt);

    if (duration.inDays > 0) {
      return '${duration.inDays} days ago';
    } else if (duration.inHours > 0) {
      return '${duration.inHours} hours ago';
    } else if (duration.inMinutes > 0) {
      return '${duration.inMinutes} minutes ago';
    } else {
      return 'Just now';
    }
  }
}
